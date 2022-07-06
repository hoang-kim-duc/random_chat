class UserSerializer < ApplicationSerializer
  attributes :id, :name, :avatar_url, :last_online, :jwt_token
  attribute :online?, key: :is_online
end
