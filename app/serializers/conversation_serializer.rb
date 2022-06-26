class ConversationSerializer < ApplicationSerializer
  attributes :id, :status, :users

  def users
    object.users.map {|user| user.slice(:id, :name)}
  end
end
