class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lockable, :trackable, :confirmable

  enum gender: %i[male female other]
  enum role: %i[user admin]
  enum status: %i[offline online]
  attr_accessor :user_node

  delegate :from_age, :to_age, :lat, :long, :radius, :gender, :enable_age_filter,
           :enable_location_filter, :enable_gender_filter, :accepted_age?,
           to: :user_setting, prefix: true, allow_nil: true

  has_many :user_conversations
  has_many :conversations, through: :user_conversations
  has_many :sent_messages, class_name: 'Message', foreign_key: :sender_id
  has_many :received_messages, class_name: 'Message', foreign_key: :recipient_id
  has_one :user_setting

  before_update :dequeue_if_going_offline, :renew_jwk_token_if_signed_in

  class << self
    def verify_jwt_token(token)
      payload = JWT.decode token, Rails.application.secret_key_base, true, { algorithm: 'HS256' }
      payload[0].with_indifferent_access
    end
  end

  def name
    "#{first_name} #{last_name}"
  end

  def still_connected?
    still_there = Broadcaster.broadcast_to_appearance(self.id, 'ping')
    return true if still_there.is_a?(Integer) && still_there.positive?

    false
  end

  def renew_jwt_token
    self.jwt_token = JWT.encode({user_id: self.id}, Rails.application.secret_key_base, 'HS256')
  end

  def renew_jwt_token!
    renew_jwt_token
    self.save!
  end

  def age
    now = Time.now.utc.to_date
    now.year - birthday.year - ((now.month > birthday.month || (now.month == birthday.month && now.day >= birthday.day)) ? 0 : 1)
  end

  private

  def renew_jwk_token_if_signed_in
    return unless current_sign_in_at_changed?

    renew_jwt_token
    Rails.logger.info("User #{self.id} has logined and renewed jwt token")
  end

  def dequeue_if_going_offline
    return unless status_changed?(to: 'offline')

    self.last_online = DateTime.now
    SystemVar.users_queue.dequeue_by_user_id(self.id)
  end
end
