class PostSerializer < ApplicationSerializer
  attributes :id, :image_path, :caption, :location, :user, :no_of_reactions,
             :created_at, :reacted_by_current_user

  def user
    object.user.to_h.slice(:id, :name, :avatar_path)
  end

  def reacted_by_current_user
    return false unless @instance_options[:viewer]

    object.user_reactions.pluck(:user_id).include? @instance_options[:viewer].id
  end
end
