module Pairing
  class MatchService < BaseService
    def call
      @result = {is_matching: true}
    end
  end
end
