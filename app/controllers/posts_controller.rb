class PostsController < ApplicationController
  include PostsControllerDocument

  before_action :set_post, :check_permission_for_modify, only: %i[ update destroy toggle_react ]
  before_action :set_user, :check_permission_for_read_post, only: :index
  # GET /posts
  def index
    render json: paging(@user.posts.includes(:user_reactions).order(created_at: :desc)), viewer: current_user
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      render json: @post, status: :created, viewer: current_user
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render json: @post, viewer: current_user
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    if @post.destroy
      render json: {success: true}
    else
      render json: {success: false}
    end
  end

  def toggle_react
    @post.toggle_react_by!(current_user.id)
    render json: { success: true }
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def check_permission_for_read_post
    raise PermissionError unless UserPolicy.can_read_posts_of_owner?(current_user, @user)
  end

  def check_permission_for_modify
    raise PermissionError unless UserPolicy.can_modify_post?(current_user, @post)
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:image, :caption).merge(user_id: current_user.id)
  end
end
