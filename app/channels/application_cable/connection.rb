# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      if current_user_id && verified_user = User.find_by(id: current_user_id)
        verified_user
      else
        reject_unauthorized_connection
      end
    end

    def current_user_id
      token = request.params[:jwt_token]
      reject_unauthorized_connection unless token

      User.verify_jwt_token(token)[:user_id]
    end
  end
end
