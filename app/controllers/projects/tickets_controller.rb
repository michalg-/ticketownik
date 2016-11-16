class Projects::TicketsController < ApplicationController

  def index
    respond_to do |format|
      format.json do
        render json: project.tickets
      end
    end
  end

  private

  def project
    @project ||= Project.find(params[:project_id])
  end
end
