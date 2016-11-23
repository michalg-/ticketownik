module Api
  class Projects::UsersController < ApplicationController

    def index
      render json: project.users.
        preload(:projects_users), project_id: project.id
    end

    def destroy
      projects_users = project.projects_users.
        where(user_id: projects_users_params[:user_ids])
      users = projects_users.
        preload(user: :photo).
        map(&:user)
      if projects_users.update_all(state: :unassigned)
        ::Projects::Users::UnassignJob.perform_later(project.id, users, current_user)
        render json: projects_users.map(&:user)
      else
        render json: {}, status: 422
      end

    end

    private

    def project
      @project ||= Project.find(params[:project_id])
    end

    def projects_users_params
      params.require(:projects_users).permit(user_ids: [])
    end
  end
end
