# frozen_string_literal: true

class StagingMailerInterceptor
  def self.delivering_email(message)
    message.to = ENV['EMAIL_RECIPIENT'].split
  end
end
ActionMailer::Base.register_interceptor(StagingMailerInterceptor) if Rails.env.staging?
