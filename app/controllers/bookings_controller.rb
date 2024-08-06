class BookingsController < ApplicationController
	before_action :require_login

	def index
		@bookings = Booking.where(user_id: current_user.id, status: nil)
	end
	
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

	def soft_delete
		@booking = Booking.find(params[:id])
		@booking.update(status: "soft_delete")
		redirect_to bookings_path, notice: "Successfully Deleted"
	end

	private

	def booking_params
		params.require(:booking).permit(:flight_id, :user_id, passengers_attributes: [:name, :email])
	end

	def require_login
		unless user_signed_in?
			flash[:error] = ["You must be logged in to access this page"]
			redirect_to new_user_session_path
		end
	end
end
