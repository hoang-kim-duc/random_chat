# frozen_string_literal: true

class Auth::ConfirmationsController < Devise::ConfirmationsController
  include Auth::ConfirmationsControllerDocument

  skip_before_action :authenticate_user!

  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  # def create
  #   super
  # end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    resource.save
    if resource.errors.empty?
      render_json(
        action: 'email_confirm',
        status: :ok,
        content: {success: true, user: resource}
      )
    else
      render_json(
        action: 'email_confirm',
        status: :forbidden,
        content: {success: false, errors: resource.errors.full_messages}
      )
    end
  end

  # protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # The path used after confirmation.
  # def after_confirmation_path_for(resource_name, resource)
  #   super(resource_name, resource)
  # end
end
