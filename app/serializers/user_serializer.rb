class UserSerializer < ApplicationSerializer
  attributes :id, :name, :avatar_path, :last_online, :jwt_token, :gender, :age, :address
  attribute :online?, key: :is_online

  def avatar_path
    object.avatar_path(100, 100)
  end

  def address
    if @instance_options[:show_address] && object.is_sharing_with?(@instance_options[:viewer_id])
      object.user_setting&.address
    end
  end
end
