module Admin
  class UsersController < AdminController
    include Admin::UsersControllerDocument

    def index
      @q = User.with_no_of_reports.ransack(params[:q])
      @users = @q.result.includes(:avatar_blob)
      render json: paging(@users).with_no_of_reports, each_serializer: Admin::UserSerializer
    end
  end
end
