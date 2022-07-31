class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :user_reactions
  has_many :reacted_by_users, through: :user_reactions, source: :user

  def no_of_reactions
    user_reactions.size
  end

  def toggle_react_by!(user_id)
    user_reaction = user_reactions.find_or_initialize_by(user_id: user_id)
    if user_reaction.id
      user_reaction.destroy!
    else
      user_reaction.save!
    end
  end

  def image_path
    if self.image.attached?
      Rails.application.routes.url_helpers.rails_blob_path(self.image)
    else
      ''
    end
  rescue
    nil
  end
end
