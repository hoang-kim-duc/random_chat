class GreetsController < ApplicationController
  before_action :authenticate_user!

  def create
    render json: {message: "Hello world"}
  end
end
