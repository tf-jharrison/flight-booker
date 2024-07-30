class FlightsController < ApplicationController
	def index
		flash.clear
		@arrival_airports = Flight.joins(:arrival_airport).pluck("airports.code")
		@departure_airports = Flight.joins(:departure_airport).pluck("airports.code")
		@dates = Flight.all.pluck("start")
	
		if params[:commit]

			@number_of_passengers = params[:passenger_number].to_i
		 	requested_date = params[:date].split('/').reverse.join('-')
		 	requested_arr_airport_id = Airport.find_by(code: params[:arrival_airport]) 
		 	requested_dep_airport_id = Airport.find_by(code: params[:departure_airport]) 

			available_flights = Flight.joins(:departure_airport, :arrival_airport).
		 							where(departure_airport_id: requested_dep_airport_id.id, arrival_airport_id: requested_arr_airport_id.id).
		 							where("DATE(start) = ?", requested_date)
			if available_flights.length != 0
				@available_flights = available_flights
			else
				flash[:error] = "No flights available"
			end
		 end
	end
end
