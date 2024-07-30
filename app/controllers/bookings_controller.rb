class BookingsController < ApplicationController

	def new
		flight_id = params[:flight_selection].to_i
		@number_of_passengers = params[:number_of_passengers].to_i
		@flight = Flight.find_by(id: flight_id)
		@booking = Booking.new
		@booking.passengers.build
	end

	def create
		@booking = Booking.new(booking_params)

		if @booking.save
			redirect_to booking_path(@booking.id)
		else
			flash[:error] = @booking.errors.full_messages
			redirect_to bookings_path
		end
	end

	def show
		@booking = Booking.find_by(id: params[:id])
	end

	private

	def booking_params
		params.require(:booking).permit(:flight_id, passengers_attributes: [:name, :email])
	end
end
