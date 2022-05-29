module Pairing
  class FindPartnerForUserJob
    include Sidekiq::Job

    def perform(*args)
      current_user = User.find(args[:current_user_id])
      found_parter = get_best_partner(current_user)
      if found_parter
      else
        SystemVar.users_queue.enqueue DataStructure::UserNode.new(current_user.id)
      end
    end

    private

    def notify_pairing_success
      accessBoa
    end

    def get_best_partner(current_user)
      result = nil
      node = SystemVar.users_queue.head
      while node.has_next? && result.nil?
        next if node.selected

        partner = User.find(node.user_id)
        result = partner if can_pair?(current_user, partner)
        node = node.next
      end
      result
    end

    def can_pair_with?(current_user, partner)
      ::MatchService.new(current_user, partner).tap(:call).result[:is_matching]
    end
  end
end
