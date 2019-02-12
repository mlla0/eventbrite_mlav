class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :auth_user, only: [:show]

  def show
  	@user = User.find(params[:id])
  	@events = Event.where(admin: @user).order('start_date ASC')
  end

  private

  def auth_user
    unless current_user.id.to_i == params[:id].to_i
      redirect_to root_path
  	end
  end
  
end
