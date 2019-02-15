class Admins::AdminController < ApplicationController
  def index
  	@users_count = User.all.count
  	@sub_events_count = Event.where(validated: nil).count
  	@val_events_count = Event.where(validated: true).count
  end
end
