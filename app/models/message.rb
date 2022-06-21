# frozen_string_literal: true

class Message < ApplicationRecord
  enum status: %i[sent received seen]
  enum tag: %i[normal generated]

  belongs_to :conversation
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  after_create :broadcast_to_recipient

  private

  def broadcast_to_recipient
    puts "status #{UsersChannel.broadcast_to User.find(recipient_id), text}"
  end
end
