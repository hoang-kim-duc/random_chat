# frozen_string_literal: true

module Auth
  class SessionsController < Devise::SessionsController
    include Auth::SessionsControllerDocument

    skip_before_action :authenticate_user!, only: [:create]

    # before_action :configure_sign_in_params, only: [:create]

    # GET /resource/sign_in
    # def new
    #   super
    # end

    # POST /resource/sign_in
    def create
      if session[:current_user_id]
        return render_json(
          action: 'log_in',
          status: :forbidden,
          content: {
            success: false,
            errors: ['user have already loged in']
          }
        )
      end
      super
      if current_user
        session[:current_user_id] = current_user.id
        render_json(
          action: 'log_in',
          status: :ok,
          content: {
            success: true,
            user: current_user.to_h
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
      signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))

      if signed_out
        render_json(
          action: 'log_out',
          status: :ok
        )
      else
        render_json(
          action: 'log_out',
          status: :forbidden,
          content: {
            success: false,
            errors: ['user have already logged out']
          }
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
end
