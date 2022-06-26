# frozen_string_literal: true

module Pairing
  class EnqueuingsController < ApplicationController
    include Pairing::EnqueuingsControllerDocument

    def create
      unless SystemVar.users_queue.user_enqueued?(current_user.id)
        Pairing::FindPartnerForUser.new(current_user.id).call
        render_json(
          action: :enqueue_user,
          status: :ok
        )
      else
        render_json(
          action: :enqueue_user,
          status: :bad_request,
          content: { success: false, error: ["user is already enqueued"] }
        )
      end
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
