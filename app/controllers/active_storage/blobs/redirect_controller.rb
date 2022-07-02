class ActiveStorage::Blobs::RedirectController < ActiveStorage::BaseController
  include ActiveStorage::SetBlob
  include Devise::Controllers::Helpers

  before_action :authenticate_user!

  def show
    return redirect_to ENV['FE_HOST'] unless authorize_user

    expires_in ActiveStorage.service_urls_expire_in
    expires_now
    redirect_to @blob.url(disposition: params[:disposition]), allow_other_host: true
  end

  def authorize_user
    UserPolicy.can_access_blob?(current_user, @blob.key)
  end
end
