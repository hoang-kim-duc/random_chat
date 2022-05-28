class EnqueuingsController < ApplicationController
  before_action :authenticate_user!

  def create
    service = EnqueueUserService.new(current_user)
    service.call
    if service.success?
      render_json(
        action: :enqueue_user,
        status: :ok
      )
    else
      render_json(
        action: :enqueue_user,
        status: :bad_request,
        content: {
          success: false,
          errors: service.errors.join('. ')
        }
      )
    end
  end

  def destroy; end
end
