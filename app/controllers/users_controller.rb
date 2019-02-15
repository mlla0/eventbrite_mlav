class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :update]
  before_action :auth_user, only: [:show, :edit]

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
      if current_user.admin == true && current_user.id.to_i != params[:id].to_i
        redirect_to admins_users_path, notice: "User profile successfully edited !"
      else
        redirect_to user_path(current_user.id), notice: "Your profile has been successfully edited !"
      end
    else
      redirect_to edit_user_path(params[:id]), alert: "#{@user.errors.full_messages.join(". ")}"
    end  
  end

  private

  def auth_user
    unless current_user.id.to_i == params[:id].to_i || current_user.admin == true
      redirect_to root_path
  	end
  end
  
end
