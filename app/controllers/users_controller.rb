class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :auth_user, only: [:show]

  def show
  	@user = User.find(params[:id])
  	@events = Event.where(admin: @user).order('start_date ASC')
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(first_name: params[:first_name], last_name: params[:last_name], description: params[:description])
      redirect_to user_path(current_user.id), success: "Your profile has been successfully edited !"
    else
      redirect_to edit_gossip_path(params[:id]), danger: "#{@gossip.errors.full_messages.join(". ")}"
    end  
  end

  private

  def auth_user
    unless current_user.id.to_i == params[:id].to_i
      redirect_to root_path
  	end
  end
  
end
