class BookingsController < ApplicationController

	def new
		flight_id = params[:flight_selection].to_i
		@number_of_passengers = params[:number_of_passengers].to_i
		@flight = Flight.find_by(id: flight_id)
		@booking = Booking.new
		@booking.passengers.build
	end

	def create
		@booking = Booking.create(booking_params)
		redirect_to booking_path(@booking.id)
	end

	def show
		@booking = Booking.find_by(id: params[:id])
	end

	private

	def booking_params
		params.require(:booking).permit(:flight_id, passengers_attributes: [:name, :email])
	end
end
