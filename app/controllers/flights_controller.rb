class FlightsController < ApplicationController
	def index
		@arrival_airports = Flight.joins(:arrival_airport).pluck("airports.code")
		@departure_airports = Flight.joins(:departure_airport).pluck("airports.code")
		@dates = Flight.all.pluck("start")
		
		requested_date = params[:date].split('/').reverse.join('-')
		requested_arr_airport_id = Airport.find_by(code: params[:arrival_airport]) 
		requested_dep_airport_id = Airport.find_by(code: params[:departure_airport]) 
		@available_flights = Flight.joins(:departure_airport, :arrival_airport).
								where(departure_airport_id: requested_dep_airport_id.id, arrival_airport_id: requested_arr_airport_id.id).
								where("DATE(start) = ?", requested_date)
	end
end
