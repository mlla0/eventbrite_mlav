class EventsController < ApplicationController
  def index
  	@events = Event.all.order('start_date ASC')
  end

  def new
  end

  def create
  end

  def show
  end
end
