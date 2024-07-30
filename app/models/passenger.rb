class Passenger < ApplicationRecord
	belongs_to :booking
	has_one :flight, through: :bookings
	validates :name, presence: true
	validates :email, presence: true
end
