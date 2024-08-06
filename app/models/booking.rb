class Booking < ApplicationRecord
	belongs_to :flight
	belongs_to :user
	has_many :passengers

	def self.soft_deleted
		where(status: 'soft deleted')
	end

	def soft_deleted?
		status == "soft deleted"
	end

	accepts_nested_attributes_for :passengers
end
