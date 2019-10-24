class Seat < ApplicationRecord
	belongs_to :flight
	belongs_to :seat_class

	validate :check_capacity
	validate :check_baggage

	private

	def check_capacity
		seats = Seat.where(flight_id: flight_id).length
		capacity = Flight.find(flight_id).capacity

		if seats >= capacity then
			errors.add(:flight_id, "Flight is full")
		end
	end

	def check_baggage
		seats = Seat.where(flight_id: flight_id)

		sum_baggage = 0

		seats.each do |s|
			sum_baggage += s.baggage.to_f
		end

		ba = Flight.find(flight_id).baggage_allowance

		if sum_baggage + baggage > ba then
			errors.add(:baggage, "Flight Baggage Capacity Exceeded by " + (-1 * (ba - sum_baggage - baggage)).to_s )
		end
	end
end







