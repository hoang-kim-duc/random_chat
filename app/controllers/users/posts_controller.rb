module Users
  class PostsController < ApplicationController
    before_action :set_user, :check_permission_for_read_post, only: :index
    before_action :set_user, :check_permission_for_read_post, only: :index

    def index
      render json: paging(@user.posts.includes(:user_reactions).order(created_at: :desc)), viewer: current_user
    end

    private

    def set_user
      @user = User.find(params[:user_id])
    end

    def check_permission_for_read_post
      raise PermissionError unless UserPolicy.can_read_posts_of_owner?(current_user, @user)
    end
  end
end
