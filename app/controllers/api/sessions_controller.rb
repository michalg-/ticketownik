module Api
  class SessionsController < ApplicationController
    skip_before_action :authorize, only: [:new, :create]

    def create
      user = User.find_by(email: user_params[:email])
      if user && user.authenticate(user_params[:password])
        session[:user_id] = user.id
        render json: {}, status: 200
      else
        render json: { errors: { password: "Email or password doesn't match" }}, status: 422
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :password)
    end
  end
end
