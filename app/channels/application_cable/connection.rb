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
      @current_user_id ||= cookies.encrypted['_random_chat']&.[]('current_user_id')
    end
  end
end
