class UserSettingsController < ApplicationController
  before_action :set_user_setting, only: %i[ show update_or_create ]

  def show
    render json: @user_setting
  end

  def update_or_create
    if @user_setting.update(user_setting_params)
      render_json(
        action: :update_user_settings,
        status: :ok,
        content: {
          user_setting: @user_setting
        }
      )
    else
      render_json(
        action: :update_user_settings,
        status: :unprocessable_entity,
        content: {
          success: false,
          errors: @user_setting.errors.full_messages
        }
      )
    end
  end

  private

    def set_user_setting
      @user_setting = UserSetting.find_or_create_by(user_id: current_user.id)
    end

    def user_setting_params
      params.require(:user_setting).permit(:from_age, :to_age, :lat, :long,
        :address, :range, :gender, :enable_age_filter, :enable_location_filter, :enable_gender_filter)
    end
end
