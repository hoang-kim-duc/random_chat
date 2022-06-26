# frozen_string_literal: true

module Pairing
  class FindPartnerForUser < BaseService
    def initialize(current_user_id)
      @current_user_id = current_user_id
      @current_user = User.find(@current_user_id)
    end

    def call
      found_partner = get_best_partner(current_user)
      if found_partner
        notify_pairing_success(current_user, found_partner)
      else
        SystemVar.users_queue.enqueue UserNode.new(current_user.id)
      end
    end

    private

    def notify_pairing_success(current_user, found_parter)
      SystemVar.users_queue.dequeue(found_parter.user_node)
      Conversation.create(user_conversations_attributes: [
        { user_id: current_user.id }, { user_id: found_parter.id }
      ])
      Broadcaster.broadcast_to_pairing(current_user.id, "pair successfully with user #{found_parter.id}")
      Broadcaster.broadcast_to_pairing(found_parter.id, "pair successfully with user #{current_user.id}")
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
      service = MatchService.new(current_user, partner)
      service.call
      service.result[:is_matching]
    end
  end
end
