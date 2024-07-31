class BookingsController < ApplicationController

	def new
		if params[:commit]
			@number_of_passengers = params[:number_of_passengers].to_i
			@flight = Flight.find_by(id: params[:flight_selection].to_i)
			@booking = Booking.new
			@booking.passengers.build
		else
			redirect_to root_path
		end
	end

	def create
		@booking = Booking.new(booking_params)

		if @booking.save
			redirect_to booking_path(@booking.id)
		else
			flash[:error] = @booking.errors.full_messages
			redirect_back(fallback_location: root_path)
		end
	end

	def show
		@booking = Booking.find_by(id: params[:id])
		
		if @booking.nil?
			flash[:error] = [ "Booking does not exist" ]
			redirect_to root_path
		end
	end

	private

	def booking_params
		params.require(:booking).permit(:flight_id, passengers_attributes: [:name, :email])
	end
end
