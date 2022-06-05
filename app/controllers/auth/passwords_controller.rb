# frozen_string_literal: true

class Auth::PasswordsController < Devise::PasswordsController
  include Auth::PasswordsControllerDocument

  skip_before_action :authenticate_user!

  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    notice = if Devise.paranoid
      resource.errors.clear
      :send_paranoid_instructions
    elsif resource.errors.empty?
      :send_instructions
    end

    if notice
      render_json(
        action: 'send_reset_password_instruction',
        status: :ok,
        content: {success: true, user: resource}
      )
    else
      render_json(
        action: 'send_reset_password_instruction',
        status: :forbidden,
        content: {
          success: false,
          errors: resource.errors.full_messages
        }
      )
    end
  rescue => e
    render_json(
      action: 'send_reset_password_instruction',
      status: :forbidden,
      content: {
        success: false,
        errors: [e.message]
      }
    )
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    if resource.errors.empty?
      render_json(
        action: 'reset_password',
        status: :ok,
        content: {success: true, user: resource}
      )
    else
      render_json(
        action: 'reset_password',
        status: :forbidden,
        content: {
          success: false,
          errors: resource.errors.full_messages
        }
      )
    end
  end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
