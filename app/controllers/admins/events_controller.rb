class Admins::EventsController < ApplicationController
	before_action :authenticate_user!, only: [:index, :destroy]
  before_action :is_admin, only: [:index, :destroy]

  def index
  	@validated_events = Event.where(validated: true)
  end

  def destroy
		@event = Event.find(params[:id])
		@event.destroy
		redirect_to admins_events_path, notice: "Event successfully deleted !"
	end

	private

  def is_admin
    unless current_user.admin == true
      redirect_to root_path
  	end
  end

end
