class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lockable, :trackable, :confirmable

  enum gender: [:male, :female, :other]
  attr_accessor :user_node

  has_many :user_conversations
  has_many :conversations, through: :user_conversations
  has_many :sent_messages, class_name: 'Message', foreign_key: :sender_id
  has_many :received_messages, class_name: 'Message', foreign_key: :recipient_id
  has_one :user_setting

  def name
    "#{first_name} #{last_name}"
  end
end
