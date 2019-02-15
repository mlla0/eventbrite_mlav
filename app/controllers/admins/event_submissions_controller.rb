class Admins::EventSubmissionsController < ApplicationController
	before_action :authenticate_user!, only: [:index, :destroy]
  before_action :is_admin, only: [:index, :destroy]

	def index
		@events_submissions = Event.where(validated: nil)
	end

	def show
		@event = Event.find(params[:id])
		@admin = User.find(@event.admin.id)
		@attendances = Attendance.where(event_id: @event.id)
	end

	def update
		@event = Event.find(params[:id])
		@event.update(validated: params[:decision])
		redirect_to admins_event_submissions_path
	end

	private

  def is_admin
    unless current_user.admin == true
      redirect_to root_path
  	end
  end

end
