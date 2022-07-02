# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    user = User.find_by_id(params[:id])
    render json: user
  end

  def avatar
  end
end