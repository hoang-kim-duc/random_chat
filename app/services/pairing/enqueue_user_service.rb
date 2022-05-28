module Pairing
  class EnqueueUserService < BaseService
    def call
      # try_to_pair
      SystemVar.users_queue.enqueue DataStructure::UserNode.new(current_user.id)
    end

    # def try_to_pair
    #   partner = UserQueue.head
    #   while partner.has_next?
    #     partner = User.find(partner.user_id)
    #     if can_pair_with?(partner)
    #     end
    #     partner = partner.next
    #   end
    # end

    # def can_pair_with?(partner)
    #   ::MatchService.new(current_user, partner).tap(:call).result[:is_matching]
    # end
  end
end
