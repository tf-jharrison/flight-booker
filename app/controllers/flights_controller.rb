class FlightsController < ApplicationController
	def index
		@arrival_airports = Flight.joins(:arrival_airport).pluck("airports.code")
		@departure_airports = Flight.joins(:departure_airport).pluck("airports.code")
		@dates = Flight.all.pluck("start")
	end
end
