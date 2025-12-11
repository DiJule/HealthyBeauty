# LiqPay Configuration Initializer
# This file loads and validates LiqPay API credentials from environment variables

Rails.application.config.to_prepare do
  LIQPAY_CONFIG = {
    public_key: ENV.fetch('LIQPAY_PUBLIC_KEY', ''),
    private_key: ENV.fetch('LIQPAY_PRIVATE_KEY', '')
  }.freeze

  # Log warning if keys are not configured (but don't fail on startup)
  if LIQPAY_CONFIG[:public_key].blank? || LIQPAY_CONFIG[:private_key].blank?
    Rails.logger.warn("⚠️  LiqPay credentials not fully configured. Set LIQPAY_PUBLIC_KEY and LIQPAY_PRIVATE_KEY in .env")
  end
end
