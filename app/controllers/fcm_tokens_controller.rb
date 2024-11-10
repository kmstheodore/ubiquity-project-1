# app/controllers/fcm_tokens_controller.rb
class FcmTokensController < ApplicationController
  # Ensure that the request is coming from an authenticated user (if using Devise or other auth)
  before_action :authenticate_user!

  def create
    # Assuming the user is logged in and has a valid session
    user = current_user

    # Store the FCM token
    token = params[:token]
    if user.fcm_tokens.create(token: token)
      render json: { message: "Token successfully stored" }, status: :ok
    else
      render json: { error: "Failed to store token" }, status: :unprocessable_entity
    end
  end
end
