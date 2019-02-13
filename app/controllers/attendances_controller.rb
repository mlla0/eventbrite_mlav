class AttendancesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :index]
  before_action :auth_user, only: [:index]

  def new
  end

  def create
  end

  def index
  	@event = Event.find(params[:event_id])
  	@participations = Attendance.where(event_id: params[:event_id])
  	@participants = []
  	@participations.each do |participation|
  		@participants << User.find(participation.participant_id)
  	end
  end

  private

  def auth_user
    unless current_user.is_admin?(Event.find(params[:event_id]))
      redirect_to event_path(params[:event_id])
    end
  end
end
