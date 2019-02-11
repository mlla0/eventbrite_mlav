class Attendance < ApplicationRecord
	after_create :new_participant_send

	belongs_to :event
	belongs_to :participant, class_name: "User"

	def new_participant_send
		UserMailer.new_participant(self).deliver_now
	end

end
