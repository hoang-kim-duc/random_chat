class PartnersController < ApplicationController
  def index
    render json: User.where(id: current_user.all_sharing_partner_ids - [current_user.id])
  end
end
