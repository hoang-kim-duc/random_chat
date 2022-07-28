# frozen_string_literal: true

module Auth
  class RegistrationsController < Devise::RegistrationsController
    include Auth::RegistrationsControllerDocument

    before_action :configure_sign_up_params, only: [:create]
    skip_before_action :authenticate_user!

    # GET /resource/sign_up
    # def new
    #   super
    # end

    # POST /resource
    def create
      build_resource(sign_up_params)
      resource.save
      if resource.persisted?
        render_json(
          action: 'sign_up',
          status: :ok,
          content: { success: true, user: resource }
        )
      else
        render_json(
          action: 'sign_up',
          status: :forbidden,
          content: {
            success: false,
            errors: resource.errors.full_messages
          }
        )
      end
    end

    # GET /resource/edit
    # def edit
    #   super
    # end

    # PUT /resource
    def update
      super
    end

    # DELETE /resource
    # def destroy
    #   super
    # end

    # GET /resource/cancel
    # Forces the session data which is usually expired after sign
    # in to be expired now. This is useful if the user wants to
    # cancel oauth signing in/up in the middle of the process,
    # removing all OAuth session data.
    # def cancel
    #   super
    # end

    # protected

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(
        :sign_up, keys: %i[first_name last_name birthday gender time_zone avatar]
      )
    end

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_account_update_params
    #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
    # end

    # The path used after sign up.
    # def after_sign_up_path_for(resource)
    #   super(resource)
    # end

    # The path used after sign up for inactive accounts.
    # def after_inactive_sign_up_path_for(resource)
    #   super(resource)
    # end
  end
end
