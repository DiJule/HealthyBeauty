require "base64"
require "openssl"

class LiqpayService
  LIQPAY_URL = "https://www.liqpay.ua/api/3/checkout".freeze

  def initialize(public_key: ENV["LIQPAY_PUBLIC_KEY"], private_key: ENV["LIQPAY_PRIVATE_KEY"])
    @public_key = public_key.to_s.strip
    @private_key = private_key.to_s.strip
    
    raise "LIQPAY_PUBLIC_KEY is not configured in environment" if @public_key.blank?
    raise "LIQPAY_PRIVATE_KEY is not configured in environment" if @private_key.blank?
  end

  def payload_for(order, options = {})
    currency = options[:currency] || "UAH"
    description = options[:description] || "Order ##{order.id} - #{order.total} #{currency}"

    params = {
      public_key: @public_key,
      version: 3,
      action: "pay",
      amount: order.total.to_s,
      currency: currency,
      description: description,
      order_id: order.id.to_s,
      server_url: options[:server_url],
      result_url: options[:result_url]
    }

    data = Base64.strict_encode64(params.to_json)
    signature = signature_for(data)

    { data: data, signature: signature, url: LIQPAY_URL }
  end

  def signature_for(data)
    digest = OpenSSL::Digest::SHA1.hexdigest(@private_key + data + @private_key)
    Base64.strict_encode64([digest].pack("H*"))
  end

  def verify?(data, signature)
    signature_for(data) == signature
  end
end
