class PartnersController < ApplicationController
  def index
    render json: User.where(id: current_user.all_sharing_partner_ids)
  end
end
