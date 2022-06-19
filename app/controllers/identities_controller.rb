class IdentitiesController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    if user_signed_in?
      render json: {role: current_user.role, logged_in: true}, status: :ok
    else
      render json: {role: nil, logged_in: false}, status: :ok
    end
  end
end
