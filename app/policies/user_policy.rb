# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  attr_accessor :user, :blob

  def initialize(user)
    @user = user
  end

  class << self
    def can_access_blob?(user, key)
      new(user).can_access_blob?(key)
    end
  end

  def can_access_blob?(key)
    @blob = ActiveStorage::Blob.find_by(key: key)
    can_user_access_blob?
  end

  private

  def can_user_access_blob?
    case type_of_blob
    when 'User_avatar'
      return true if user.avatar.id == blob.id
      conversation_ids = user.conversations.sharing.ids
      user_ids = UserConversation.where(conversation_id: conversation_ids).pluck(:user_id).uniq
      blob_ids = ActiveStorage::Attachment.where(record_type: "User", record_id: user_ids).pluck(:blob_id)
      blob_ids.include?(blob.id)
    else
      false
    end
  end

  def type_of_blob
    @type_of_blob ||= "#{blob.attachments.first.record_type}_#{blob.attachments.first.name}"
  end
end
