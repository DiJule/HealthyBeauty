class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    @cart = current_user.cart
    @order = Order.new(payment_method: "cash")
    @delivery_options = DeliveryOption.all
  end

  def create
    @cart = current_user.cart
    @order = current_user.orders.build(order_params)

    @order.payment_method ||= "cash"

    @order.total = @cart.total_price
    @order.status = "pending"

    if @order.save
      @cart.cart_items.each do |item|
        @order.order_items.create!(
          product: item.product,
          quantity: item.quantity,
          price: item.product.price
        )
      end

      @order.create_payment!(
        method: @order.payment_method,
        status: "pending"
      )

      @cart.cart_items.destroy_all

      if @order.payment_method == "liqpay"
        redirect_to new_payment_path(order_id: @order.id)
      else
        redirect_to order_path(@order), notice: "Замовлення створено!"
      end
    else
      @delivery_options = DeliveryOption.all
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def index
    @orders = current_user.orders.order(created_at: :desc)
  end

  private

  def order_params
    params.require(:order).permit(
      :delivery_option,
      :delivery_type,
      :delivery_method,
      :payment_method,
      :contact_name,
      :contact_phone,
      :contact_email
    )
  end
end
