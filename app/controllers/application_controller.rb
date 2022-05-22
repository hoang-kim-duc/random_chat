class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  respond_to :json

  def render_json(action: nil, status:, content: {success: true, errors: []})
    content[:success] = true unless defined?(content[:success])
    content = {action: action}.merge!(content) if action
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
end
