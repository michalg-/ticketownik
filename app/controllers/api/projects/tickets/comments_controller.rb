module Api::Projects::Tickets
  class CommentsController < ApplicationController
    def index
      render json: ticket.comments
    end

    def create
      comment = ticket.comments.new(comment_params)
      if comment.save
        Comments::CreateJob.perform_later(ticket, comment, current_user)
        render json: comment
      else
        render json: { errors: comment.errors.messages }, status: 422
      end
    end

    private

    def project
      @project ||= Project.find(params[:project_id])
    end

    def ticket
      @ticket ||= project.tickets.find(params[:ticket_id])
    end

    def comment_params
      params.require(:comment).permit(:content).
        merge(author: current_user)
    end
  end
end
