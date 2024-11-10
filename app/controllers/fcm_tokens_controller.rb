class FcmTokensController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [ :create ]
  before_action :authenticate_user!

  def create
    user = current_user
    token = params[:fcm_token]

    if user.update(fcm_token: token)
      render json: { message: "Token successfully stored" }, status: :ok
    else
      render json: { error: "Failed to store token" }, status: :unprocessable_entity
    end
  end
end
