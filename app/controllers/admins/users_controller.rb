class Admins::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :destroy]
  before_action :is_admin, only: [:index, :destroy]

	def index
		@users = User.all
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		redirect_to admins_users_path, notice: "User profile successfully deleted !"
	end

	private

  def is_admin
    unless current_user.admin == true
      redirect_to root_path
  	end
  end

end
