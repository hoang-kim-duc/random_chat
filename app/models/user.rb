class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lockable, :trackable, :confirmable

  enum gender: [:male, :female, :other]
  enum role: [:user, :admin]
  enum status: [:offline, :online]
  attr_accessor :user_node

  has_many :user_conversations
  has_many :conversations, through: :user_conversations
  has_many :sent_messages, class_name: 'Message', foreign_key: :sender_id
  has_many :received_messages, class_name: 'Message', foreign_key: :recipient_id
  has_one :user_setting

  before_update :dequeue_if_going_offline

  def name
    "#{first_name} #{last_name}"
  end

  def still_connected?
    still_there = AppearanceChannel.broadcast_to(self, 'ping')
    return true if still_there.is_a?(Integer) && still_there.positive?

    false
  end

  private

  def dequeue_if_going_offline
    return unless status_changed?(to: 'offline')

    self.last_online = DateTime.now
    SystemVar.users_queue.dequeue_by_user_id(self.id)
  end
end
