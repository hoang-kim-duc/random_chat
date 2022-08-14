class PostSerializer < ApplicationSerializer
  attributes :id, :image_path, :caption, :location, :user, :no_of_reactions, :created_at

  def user
    object.user.to_h.slice(:id, :name, :avatar_path)
  end
end
