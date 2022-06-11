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

    def destroy; end
  end
end
