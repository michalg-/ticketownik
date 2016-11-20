module Api
  class UsersController < ApplicationController
    def show
      render json: current_user
    end

    def update
      begin
        User::Update.new(user_params.merge(id: current_user.id)).process
        UserNotificationJob.perform_later('User profile updated', current_user)
        render json: current_user.reload
      rescue ActiveRecord::Rollback
        render json: { errors: current_user.errors.messages }, status: 422
      end
    end

    private

    def user_params
      params.require(:user).permit(:name, :photo, :remove_photo)
    end
  end
end
