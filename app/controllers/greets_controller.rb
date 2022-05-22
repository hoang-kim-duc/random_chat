class GreetsController < ApplicationController
  before_action :authenticate_user!

  def create

    # UsersChannel.broadcast_to User.find(33), {a: 'b'}
    render json: {message: "Hello world"}
  end

  def add_user
    $user_queue.enqueue DataStructure::UserNode.new(params[:user_id])
    binding.pry
  end

  def show
    binding.pry
  end
end
