module Authenticable
  extend ActiveSupport::Concern
  included do
    before_filter :authorize

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
    helper_method :current_user

    def authorize
      redirect_to login_path unless current_user
    end
  end

end
