class UserSerializer < ApplicationSerializer
  attributes :id, :name, :avatar_path, :last_online, :jwt_token, :gender, :age
  attribute :online?, key: :is_online

  def avatar_path
    object.avatar_path(100, 100)
  end
end
