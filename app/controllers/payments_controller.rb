class PaymentsController < ApplicationController
  before_action :authenticate_user!, only: [ :new ]

  def new
    @order = current_user.orders.find(params[:order_id])

    begin
      service = LiqpayService.new
      @liqpay = service.payload_for(@order, server_url: payments_callback_url, result_url: order_url(@order))
    rescue => e
      Rails.logger.error("LiqPay service error: #{e.message}")
      redirect_to order_path(@order), alert: "Помилка при ініціалізації платіжної системи: #{e.message}"
    end
  end

  # LiqPay server callback (IPN)
  skip_before_action :verify_authenticity_token, only: [ :callback ]
  def callback
    data = params[:data]
    signature = params[:signature]

    begin
      service = LiqpayService.new
    rescue => e
      Rails.logger.error("LiqPay service initialization failed: #{e.message}")
      render plain: "Configuration error", status: :internal_server_error
      return
    end

    unless data && signature && service.verify?(data, signature)
      Rails.logger.warn("Invalid LiqPay signature or missing params")
      render plain: "Invalid signature", status: :bad_request
      return
    end

    payload = JSON.parse(Base64.decode64(data)) rescue {}
    order_id = payload["order_id"].to_s
    order = Order.find_by(id: order_id)

    if order.nil?
      Rails.logger.warn("LiqPay callback: Order ##{order_id} not found")
      render plain: "Order not found", status: :not_found
      return
    end

    payment = order.payment || order.build_payment(method: "liqpay")

    # LiqPay sends status values like 'success' for completed payments
    if payload["status"] == "success"
      payment.status = "paid"
      order.status = "confirmed" if order.status == "pending"
      Rails.logger.info("LiqPay payment successful for order ##{order_id}")
    else
      payment.status = "failed"
      Rails.logger.info("LiqPay payment failed for order ##{order_id}, status: #{payload["status"]}")
    end

    payment.save!
    order.save!

    render plain: "OK"
  end
end
