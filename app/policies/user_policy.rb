# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  attr_accessor :user, :blob

  class << self
    def can_access_blob?(user, key)
      new(user).can_access_blob?(key)
    end

    def can_modify_post?(user, post)
      new(user).can_modify_post?(post)
    end

    def can_read_posts_of_owner?(reader, owner)
      new(reader).can_read_posts_of_owner?(owner)
    end
  end

  def initialize(user)
    @user = user
  end

  def can_access_blob?(key)
    @blob = ActiveStorage::Blob.find_by(key: key)
    can_user_access_blob?
  end

  def can_modify_post?(post)
    post.user_id == user.id
  end

  def can_read_posts_of_owner?(owner)
    user == owner || in_sharing_conversation?(user, owner)
  end

  private

  def can_user_access_blob?
    case type_of_blob
    when 'User_avatar'
      blob_owner = blob.attachments[0].record
    when 'Post_image'
      blob_owner = blob.attachments[0].record.user
    else
      blob_owner = nil
    end
    return false unless blob_owner

    user == blob_owner || in_sharing_conversation?(user, blob_owner)
  end

  def in_sharing_conversation?(user1, user2)
    conversation_ids = user1.conversations.sharing.ids
    user2.user_conversations.where(conversation_id: conversation_ids).any?
  end

  def type_of_blob
    @type_of_blob ||= "#{blob.attachments.first.record_type}_#{blob.attachments.first.name}"
  end
end
