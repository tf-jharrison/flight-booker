# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Flight.destroy_all
Airport.destroy_all


airport_codes = ["LAX", "JFK", "ORD", "ATL", "DFW", "DEN", "SFO", "SEA", "MIA", "LAS", "IN", "OUT"]
airports = Array.new
airport_codes.each do |airport_code|
	airports << Airport.create!(code: airport_code)
end

Flight.create!(
  [
    { departure_airport: airports[0], arrival_airport: airports[1], start: Time.now + 1.day, flight_duration: 360 },
    { departure_airport: airports[0], arrival_airport: airports[2], start: Time.now + 2.days, flight_duration: 150 },
    { departure_airport: airports[2], arrival_airport: airports[3], start: Time.now + 3.days, flight_duration: 120 },
    { departure_airport: airports[3], arrival_airport: airports[4], start: Time.now + 4.days, flight_duration: 180 },
    { departure_airport: airports[4], arrival_airport: airports[5], start: Time.now + 5.days, flight_duration: 240 },
    { departure_airport: airports[5], arrival_airport: airports[6], start: Time.now + 6.days, flight_duration: 150 },
    { departure_airport: airports[6], arrival_airport: airports[7], start: Time.now + 7.days, flight_duration: 210 },
    { departure_airport: airports[7], arrival_airport: airports[8], start: Time.now + 8.days, flight_duration: 180 },
    { departure_airport: airports[8], arrival_airport: airports[9], start: Time.now + 9.days, flight_duration: 300 },
    { departure_airport: airports[9], arrival_airport: airports[0], start: Time.now + 10.days, flight_duration: 360 },
    { departure_airport: airports[10], arrival_airport: airports[11], start: Time.now + 10.days, flight_duration: 360 }
  ]
)