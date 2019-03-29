Recaptcha.configure do |config|
  config.site_key = Settings.recaptcha.public
  config.secret_key = Settings.recaptcha.private
end
