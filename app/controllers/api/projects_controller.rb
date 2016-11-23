class Api::ProjectsController < ApplicationController
  def index
    authorize(projects = policy_scope(Project).order(name: :asc))
    render json: projects
  end

  def create
    begin
      authorize(project = Project.new(project_params))
      Api::Projects::Create.new(project, current_user).process
      render json: project
    rescue ActiveRecord::Rollback
      render json: { errors: project.errors.messages }, status: 422
    end
  end

  def update
    authorize(project)
    if project.update(project_params)
      ::Projects::UpdateJob.perform_later(project)
      render json: project
    else
      render json: { errors: project.errors.messages }, status: 422
    end
  end

  def destroy
    authorize(project)
    if project.destroy
      ::Projects::DestroyJob.perform_later(project.to_json)
      render json: project
    else
      render json: {}, status: 422
    end
  end

  def show
    authorize(project)
    render json: project
  end

  private

  def project
    @project ||= policy_scope(Project).find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end
end
