Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.staging?

if Rails.env.production? or Rails.env.staging?
  ActionMailer::Base.smtp_settings = ActionMailer::Base.smtp_settings.merge({
    :password => Rails.application.secrets.mandrill_api_key
  })
end
