# frozen_string_literal: true

class UsersController < ApplicationController
  include UsersControllerDocument

  before_action :find_user

  def show
    render json: @user
  end

  def update
    current_user.update! user_params

    render json: {success: true}
  end

  private

  def find_user
    @user = User.find_by_id(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :birthday,
      :gender, hobbies: [])
  end
end
