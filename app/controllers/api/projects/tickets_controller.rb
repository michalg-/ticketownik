module Api::Projects
  class TicketsController < ApplicationController
    def index
      render json: project.tickets
    end

    def create
      ticket = project.tickets.new(ticket_params)
      if ticket.save
        Ticket::CreateJob.perform_later(ticket)
        render json: ticket
      else
        render json: { errors: ticket.errors.messages }, status: 422
      end
    end

    private

    def project
      @project ||= Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:title, :description)
    end
  end
end
