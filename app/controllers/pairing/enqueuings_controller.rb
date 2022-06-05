module Pairing
  class EnqueuingsController < ApplicationController
    before_action :authenticate_user!

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
