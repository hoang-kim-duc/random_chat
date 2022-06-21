# frozen_string_literal: true

class Frontend
  class << self
    def reset_password_url(token:)
      "#{ENV['FE_HOST']}/users/reset-password/#{token}"
    end

    def email_confirmation_url(token:)
      "#{ENV['FE_HOST']}/confirm-email-register/#{token}"
    end
  end
end
