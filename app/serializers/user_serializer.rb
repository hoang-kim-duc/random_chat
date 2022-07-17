class UserSerializer < ApplicationSerializer
  attributes :id, :name, :avatar_path, :last_online, :jwt_token
  attribute :online?, key: :is_online

  def last_online
    process_time(object.last_online, @instance_options[:viewer])
  end
end
