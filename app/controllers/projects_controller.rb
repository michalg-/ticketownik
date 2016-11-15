class ProjectsController < ApplicationController

  def index
    projects = Project.all
    respond_to do |format|
      format.html do
        render :index, locals: {
          projects: projects
        }
      end
      format.json do
        render json: projects
      end
    end
  end

  def new
    render :new
  end

  def create
    project = Project.new(project_params)
    if project.save
      ProjectRelayJob.perform_later(project)
      render json: project
    else
      render json: { errors: project.errors.messages }, status: 422
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end

end
