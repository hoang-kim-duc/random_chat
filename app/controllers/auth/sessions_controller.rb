# frozen_string_literal: true

class Auth::SessionsController < Devise::SessionsController
  include Auth::SessionsControllerDocument
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    return render_json(
      action: 'log_in',
      status: :forbidden,
      content: {
        success: false,
        errors: ['user have already loged in']
      }
    ) if session[:current_user_id]
    super
    if current_user
      session[:current_user_id] = current_user.id
      render_json(
        action: 'log_in',
        status: :ok,
        content: {
          success: true,
          user: current_user
        }
      )
    else
      render_json(
        action: 'log_in',
        status: :unauthorized,
        content: {
          success: false,
          errors: ['wrong email or password']
        }
      )
    end
  end

  # DELETE /resource/sign_out
  def destroy
    super do
      render_json(
        action: 'log_out',
        status: :ok
      )
    end
  end

  private

  def respond_to_on_destroy; end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
