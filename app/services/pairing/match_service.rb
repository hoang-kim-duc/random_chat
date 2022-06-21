module Pairing
  class MatchService < BaseService
    attr_accessor :user1, :user2, :result

    def initialize(user1, user2)
      @user1 = user1
      @user2 = user2
      @reasons = []
      errors.add('users are invalid') unless validate_users
    end

    def call
      match_gender if both_enable_gender_filter?
      match_age_range if both_enable_location_filter?
      match_location if both_enable_age_filter?
      @result = {is_matching: @reasons.empty?, reasons: @reasons}
    end

    private

    def match_location
      distance = calc_distance(user1.user_setting_lat, user1.user_setting_long, user2.user_setting_lat, user2.user_setting_long)
      @reasons << "users2's location was not accepted by user1" if user1.user_setting_radius < distance
      @reasons << "users1's location was not accepted by user2" if user2.user_setting_radius < distance
    end

    def calc_distance(lat1, long1, lat2, long2)
      lat1, long1, lat2, long2 = [lat1, long1, lat2, long2].map{ |d| to_radian(d) }
      dlong = long2 - long1
      dlat = lat2 - lat1
      a = Math.sin(dlat/2)**2 + Math.cos(lat1) * Math.cos(lat2) * Math.sin(dlong/2)**2
      c = 2 * Math.asin(Math.sqrt(a))
      # Radius of earth in kilometers is 6371
      6371 * c
    end

    def to_radian(degrees)
      degrees * Math::PI / 180
    end

    def match_gender
      @reasons << "users2 gender was not accepted by user1" if user1.user_setting_gender != user2.gender
      @reasons << "users1 gender was not accepted by user2" if user2.user_setting_gender != user1.gender
    end

    def match_age_range
      @reasons << "users2's age was not accepted by user1" unless user1.user_setting_accepted_age?(user2.age)
      @reasons << "users1's age was not accepted by user2" unless user2.user_setting_accepted_age?(user1.age)
    end

    def validate_users
      @user1 && @user2
    end

    def both_enable_gender_filter?
      user1.user_setting_enable_gender_filter && user2.user_setting_enable_gender_filter
    end

    def both_enable_location_filter?
      user1.user_setting_enable_location_filter && user2.user_setting_enable_location_filter
    end

    def both_enable_age_filter?
      user1.user_setting_enable_age_filter && user2.user_setting_enable_age_filter
    end
  end
end
