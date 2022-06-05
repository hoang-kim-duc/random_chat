module Pairing
  class FindPartnerForUser < BaseService
    def initialize(current_user_id)
      @current_user_id = current_user_id
      @current_user = User.find(@current_user_id)
    end

    def call
      return if SystemVar.users_queue.user_enqueued?(current_user.id)

      found_parter = get_best_partner(current_user)
      if found_parter
        notify_pairing_success(current_user, found_parter)
      else
        SystemVar.users_queue.enqueue UserNode.new(current_user.id)
      end
    end

    private

    def notify_pairing_success(current_user, found_parter)
      SystemVar.users_queue.dequeue(found_parter.user_node)
      puts "pair success for #{current_user.name} and #{found_parter.name}"
    end

    def get_best_partner(current_user)
      result = nil
      node = SystemVar.users_queue.head
      return nil unless node

      while node.present? && result.nil?
        next if node.selected

        partner = User.find(node.user_id)
        if can_pair?(current_user, partner)
          partner.user_node = node
          result = partner
        end
        node = node.next
      end

      result
    end

    def can_pair?(current_user, partner)
      MatchService.new(current_user, partner).tap(&:call).result[:is_matching]
    end
  end
end
