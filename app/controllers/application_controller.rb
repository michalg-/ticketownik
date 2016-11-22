class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Authenticable
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    respond_to do |format|
      format.html do
        flash[:alert] = 'You are not authorized to perform this action.'
        redirect_to(request.referrer || root_path)
      end
      format.json do
        render json: {}, status: 403
      end
    end
  end
end
