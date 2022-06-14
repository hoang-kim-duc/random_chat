module Pairing
  class MatchService < BaseService

    def initialize(user1, user2)
      @user1 = user1
      @user2 = user2
      errros.add('users are invalid') unless validate_users
    end

    def call
      @result = {is_matching: false}
    end

    private

    def validate_users
      @user1 && @user2
    end
  end
end
