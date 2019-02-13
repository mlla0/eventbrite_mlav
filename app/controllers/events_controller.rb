class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
  	@events = Event.all.order('start_date ASC')
  end

  def new
  end

  def create
  	@event = Event.new(start_date: params[:start_date], duration: params[:duration], title: params[:title], description: params[:description], price: params[:price], location: params[:location], admin_id: current_user.id)

    if @event.save
      redirect_to event_path(@event.id), notice: "Event successfully created !"
    else
      redirect_to new_event_path, alert: "#{@event.errors.full_messages.join(". ")}"
    end
  end

  def show
  	@event = Event.find(params[:id])
  	@admin = User.find(@event.admin.id)
  	@attendances = Attendance.where(event_id: @event.id)
  end
end
