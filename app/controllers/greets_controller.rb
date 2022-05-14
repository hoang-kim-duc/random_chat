class GreetsController < ApplicationController
  before_action :authenticate_user!

  def create

    # UsersChannel.broadcast_to User.find(33), {a: 'b'}
    render json: {message: "Hello world"}
  end
end
