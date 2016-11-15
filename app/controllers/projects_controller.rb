class ProjectsController < ApplicationController

  def index
    respond_to do |format|
      format.html
      format.json do
        render json: Project.order(name: :asc)
      end
    end
  end

  def new
    render partial: 'projects/form'
  end

  def create
    project = Project.new(project_params)
    if project.save
      Projects::CreateJob.perform_later(project)
      render json: project
    else
      render json: { errors: project.errors.messages }, status: 422
    end
  end

  def destroy
    if project.destroy
      Projects::DestroyJob.perform_later
      render json: project
    else
      render json: {}, status: 422
    end
  end

  private

  def project
    @project ||= Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end

end
