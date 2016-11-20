module Api
  class Projects::UsersController < ApplicationController

    def index
      render json: User.all
    end

    private

    def project
      @project ||= Project.find(params[:project_id])
    end
  end
end
