Rails.application.config.to_prepare do
  LIQPAY_CONFIG = {
    public_key: Rails.application.credentials.dig(:liqpay, :public_key),
    private_key: Rails.application.credentials.dig(:liqpay, :private_key)
  }.freeze

  if LIQPAY_CONFIG[:public_key].blank? || LIQPAY_CONFIG[:private_key].blank?
    Rails.logger.warn("⚠️ LiqPay credentials are missing in Rails credentials")
  end
end
