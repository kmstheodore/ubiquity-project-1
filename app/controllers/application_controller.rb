class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  before_action :authenticate_user!
  private

  def authenticate_user!
    unless user_signed_in? || allowed_pages.include?(action_name)
      redirect_to request_demo_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :discord_id ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :discord_id ])
  end

  def allowed_pages
    %w[request_demo new create]
  end
end
