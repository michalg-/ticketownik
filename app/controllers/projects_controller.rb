class ProjectsController < ApplicationController

  def index
    render :index
  end

  def new
    render partial: 'projects/form'
  end

  def edit
    render partial: 'projects/form'
  end


  def show
    render :show, locals: {
      project: project
    }
  end

  private

  def project
    @project ||= Project.find(params[:id])
  end

end
