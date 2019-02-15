class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :auth_user, only: [:edit, :update, :destroy]

  def index
  	@events = Event.all.order('start_date ASC')
  end

  def new
  end

  def create
  	@event = Event.new(start_date: params[:start_date], duration: params[:duration], title: params[:title], description: params[:description], price: params[:price], location: params[:location], admin_id: current_user.id).event_picture.attach(params[:event_picture])
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

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(start_date: params[:start_date], duration: params[:duration], title: params[:title], description: params[:description], price: params[:price], location: params[:location])
      redirect_to event_path(params[:id]), notice: "Your event has been successfully edited !"
    else
      redirect_to edit_event_path(params[:id]), alert: "#{@event.errors.full_messages.join(". ")}"
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to root_path, notice: "Event successfully deleted !"
  end

  private

  def auth_user
    unless current_user.is_admin?(Event.find(params[:id]))
      redirect_to event_path(params[:id])
    end
  end
end
