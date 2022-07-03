class UserSerializer < ApplicationSerializer
  attributes :id, :name, :avatar_url, :last_online
  attribute :online?, key: :is_online
end
