module Admin
  class AdminController < ApplicationController
    before_action :authenticate_admin

    private

    def authenticate_admin
      return if current_user.admin?

      render json: {errors: 'only admin can perform this action'}, status: :unauthorized
    end
  end
end
