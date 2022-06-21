# frozen_string_literal: true

class GreetsController < ApplicationController
  def create
    # Devise::Mailer.confirmation_instructions(User.last, 'awdawd').deliver_now
    # UsersChannel.broadcast_to User.find(33), {a: 'b'}
    render json: { message: 'Hello world' }
  end

  def add_user
    SystemVar.users_queue.enqueue DataStructure::UserNode.new(params[:user_id])
    binding.pry
  end

  def show
    binding.pry
  end
end
