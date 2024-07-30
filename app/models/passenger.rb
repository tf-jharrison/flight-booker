class Passenger < ApplicationRecord
	belongs_to :booking
	has_one :flight, through: :bookings
end
