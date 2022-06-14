module Pairing
  class EnqueuingsController < ApplicationController
    include Pairing::EnqueuingsControllerDocument

    def create
      Pairing::FindPartnerForUser.new(current_user.id).call
      render_json(
        action: :enqueue_user,
        status: :ok
      )
    end

    def destroy
      SystemVar.users_queue.dequeue_by_user_id(current_user.id)
      render_json(
        action: :dequeue_user,
        status: :ok
      )
    end
  end
end
