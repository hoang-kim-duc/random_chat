class UserSerializer < ApplicationSerializer
  attributes :id, :name, :avatar_url, :last_online

  def avatar_url
    Rails.application.routes.url_helpers.rails_blob_url(object.avatar)
  end
end
