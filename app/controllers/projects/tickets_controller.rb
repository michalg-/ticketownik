class Projects::TicketsController < ApplicationController

  def index
  end

  def new
    render partial: 'projects/tickets/form'
  end

  def edit
    render partial: 'projects/tickets/form'
  end

  private

  def project
    @project ||= Project.find(params[:project_id])
  end
end
