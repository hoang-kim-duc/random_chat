class PostSerializer < ApplicationSerializer
  attributes :id, :image_path, :caption, :user_id, :no_of_reactions, :created_at

  def created_at
    process_time(object.created_at, @instance_options[:viewer])
  end
end
