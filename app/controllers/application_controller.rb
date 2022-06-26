# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  before_action :authenticate_user!

  respond_to :json

  rescue_from StandardError do |error|
    render_json(
      status: :bad_request,
      content: {
        success: false,
        errors: [error.message]
      }
    )
  end

  def render_json(status:, action: nil, content: { success: true, errors: [] })
    content[:success] = true unless defined?(content[:success])
    content = { action: }.merge!(content) if action
    render json: content, status: status
  end

  def authenticate_user!
    return if user_signed_in?

    render_json(
      status: :unauthorized,
      content: {
        success: false,
        errors: ['Unauthorized! User have to log in first']
      }
    )
  end

  def paging(collection)
    collection.page(params[:page]).per(params[:per_page])
  end
end
