module Authenticable

  # Devise methods overwrites

  def current_user
    @current_user ||= User.find_by(auth_token: request.headers['Authorization'])
  end

  def authenticate_with_token!
    render json: { errors: "Not authenticated" },
                  status: :unauthorized unless user_signed_in? || admin_signed_in?
  end

  def user_signed_in?
    current_user.present?
  end

  def admin_signed_in?
    if request.present? && request.headers.present? && request.headers['Authorization'].present?
      Rack::Utils.secure_compare Rails.application.config.auth_token, request.headers['Authorization']
    end
  end
end
