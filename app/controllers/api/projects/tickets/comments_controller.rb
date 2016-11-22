module Api::Projects::Tickets
  class CommentsController < ApplicationController

    def index
      authorize(comments = ticket.comments)
      render json: comments
    end

    def show
      authorize(comment)
      render json: comment
    end

    def create
      authorize(comment = ticket.comments.new(comment_params))
      if comment.save
        Comments::CreateJob.perform_later(ticket, comment, current_user)
        render json: comment
      else
        render json: { errors: comment.errors.messages }, status: 422
      end
    end

    def destroy
      authorize(comment)
      if comment.destroy
        Comments::DestroyJob.perform_later(ticket, comment.to_json, current_user)
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

    def comment
      @comment ||= policy_scope(ticket.comments).find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:content).
        merge(author: current_user)
    end
  end
end
