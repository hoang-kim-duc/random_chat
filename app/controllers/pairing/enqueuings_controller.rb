module Pairing
  class EnqueuingsController < ApplicationController

    def create
      Pairing::FindPartnerForUserJob.perform_async(current_user_id: current_user.id)
      render_json(
        action: :enqueue_user,
        status: :ok
      )
    end

    def destroy; end
  end
end
