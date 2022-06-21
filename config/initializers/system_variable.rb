# frozen_string_literal: true

Dir["#{Rails.root}/lib/data_structure/*.rb"].each { |file| require file }

module SystemVar
  class << self
    attr_reader :users_queue

    def users_queue
      @users_queue ||= DataStructure::UserQueue.new
    end
  end
end
