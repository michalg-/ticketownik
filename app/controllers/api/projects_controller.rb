module Api
  class ProjectsController < ApplicationController
    def index
      render json: Project.order(name: :asc)
    end

    def create
      project = Project.new(project_params)
      if project.save
        ::Projects::CreateJob.perform_later(project)
        render json: project
      else
        render json: { errors: project.errors.messages }, status: 422
      end
    end

    def update
      if project.update(project_params)
        ::Projects::UpdateJob.perform_later(project)
        render json: project
      else
        render json: { errors: project.errors.messages }, status: 422
      end
    end

    def destroy
      if project.destroy
        ::Projects::DestroyJob.perform_later(project.to_json)
        render json: project
      else
        render json: {}, status: 422
      end
    end

    def show
      render json: project
    end

    private

    def project
      @project ||= Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, :description)
    end
  end
end
