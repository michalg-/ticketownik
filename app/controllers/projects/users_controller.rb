class Projects::UsersController < ApplicationController

  def index
    render partial: 'projects/users/form'
  end

end
