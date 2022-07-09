# frozen_string_literal: true

class Message < ApplicationRecord
  include AASM

  aasm whiny_transitions: false

  aasm column: :status do
    state :sent, initial: true
    state :received, after_enter: :notify_latest_status_to_sender
    state :seen, after_enter: :notify_latest_status_to_sender

    event :broadcast do
      transitions from: :sent, to: :received, if: :sent_to_recipient_successfully?
    end

    event :recipent_read do
      transitions from: :received, to: :seen
    end
  end

  belongs_to :conversation
  belongs_to :sender, class_name: 'User', optional: true
  belongs_to :recipient, class_name: 'User'
  scope :unread, -> { where.not(status: :seen) }

  private

  def notify_latest_status_to_sender
    Broadcaster.broadcast_to_msg_latest_status(
      self.sender_id,
      { message: { id: self.id, uuid: self.uuid, status: self.status } }
    )
  end

  def sent_to_recipient_successfully?
    broadcast = Broadcaster.broadcast_to_new_message(
      recipient.id,
      self.to_h(viewer: recipient)
    )
    broadcast >= 1
  end
end
