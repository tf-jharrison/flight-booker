class Booking < ApplicationRecord
	belongs_to :flight
	belongs_to :user
	has_many :passengers

	accepts_nested_attributes_for :passengers
end
