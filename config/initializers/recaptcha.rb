Recaptcha.configure do |config|
  config.public_key = Rails.application.secrets[:recaptcha]['public_key']
  config.private_key = Rails.application.secrets[:recaptcha]['private_key']
  config.use_ssl_by_default = true
end