class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
	
	after_create :welcome_send
	
	has_many :attendances, foreign_key: "participant_id", class_name: "Attendance"
	has_many :events, through: :attendances
	has_many :admin_events, foreign_key: "admin_id", class_name: "Event"

	def welcome_send
		UserMailer.welcome_email(self).deliver_now
	end

	def is_admin?(event)
		if Event.find(event.id).admin == self 
			return true
		end
	end

	def is_participant?(event)
		a = Attendance.where(event_id: event.id)
		a.each do |attendance|
			if self.id.to_i == attendance.participant_id.to_i
				return true			
			end
		end
			return false
	end

end