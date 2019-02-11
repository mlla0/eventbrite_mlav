class Event < ApplicationRecord

	validates :start_date, 
		presence: true
	validate :start_date_is_after_time_now
	validates :duration, 
		presence: true,
		numericality: { greater_than: 0}
	validate :duration_is_multiple_of_5
	validates :title, 
		presence: true,
		length: {minimum: 5, maximum: 140}
	validates :description,
		presence: true,
		length: {minimum: 20, maximum: 1000}
	validates :price,
		presence: true,
		numericality: {greater_than: 1, less_than: 1000}
	validates :location,
		presence: true
	
	belongs_to :admin, class_name: "User"

	def start_date_is_after_time_now
		errors.add(:start_date, "must be before time now.") unless 
			start_date > Time.now
	end

	def duration_is_multiple_of_5
		errors.add(:duration, "must be multiple of five.") unless 
			duration%5 == 0
	end

end
