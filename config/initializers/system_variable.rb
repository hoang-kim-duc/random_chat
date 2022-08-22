# frozen_string_literal: true

Dir["#{Rails.root}/lib/data_structure/*.rb"].each { |file| require file }

module SystemVar
  class << self
    attr_reader :users_queue

    def users_queue
      @users_queue ||= DataStructure::UserQueue.new
    end

    def pair_successfully_messasge(partner_name)
      "You was matched with #{partner_name}"
    end

    def requested_share_profile(partner_name)
      "You agreed to share profile with #{partner_name}"
    end

    def partner_shared_profile(partner_name)
      "#{partner_name} agreed to share profile with you"
    end

    def close_conversation(partner_name)
      "You ended this conversation. You and #{partner_name} can not chat and see each other information from now"
    end

    def partner_close_conversation(partner_name)
      "#{partner_name} ended this conversation. You and #{partner_name} can not chat and see each other information from now"
    end
  end
end
