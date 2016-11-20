module Api::Projects
  class TicketsController < ApplicationController
    def index
      render json: project.tickets.preload(:creator).order(created_at: :desc)
    end

    def create
      ticket = project.tickets.new(ticket_params.merge(creator_id: current_user.id))
      if ticket.save
        ::Tickets::CreateJob.perform_later(ticket, current_user)
        render json: ticket
      else
        render json: { errors: ticket.errors.messages }, status: 422
      end
    end

    def update
      if ticket.update(ticket_params)
        ::Tickets::UpdateJob.perform_later(ticket, current_user)
        render json: ticket
      else
        render json: { errors: ticket.errors.messages }, status: 422
      end
    end

    def destroy
      if ticket.destroy
        ::Tickets::DestroyJob.perform_later(ticket.to_json, current_user)
        render json: ticket
      else
        render json: {}, status: 422
      end
    end

    private

    def project
      @project ||= Project.find(params[:project_id])
    end

    def ticket
      @ticket ||= project.tickets.find(params[:id])
    end

    def ticket_params
      params.require(:ticket).permit(:title, :description, :priority).
        merge(status: :waiting)
    end
  end
end
