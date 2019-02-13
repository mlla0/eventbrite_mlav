class AttendancesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :index]
  before_action :auth_user, only: [:index]

  def new
    @event = Event.find(params[:event_id])
    @stripe_price = @event.price * 100
  end

  def create
    @amount = params[:amount]

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'eur'
    )

    Attendance.create(participant: current_user, event: Event.find(params[:event_id]), stripe_customer_id: params[:stripeToken])
    redirect_to event_path(params[:event_id])

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_event_attendance_path(params[:event_id])
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
