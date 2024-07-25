module FlightsHelper
	def display_formatted_dates(unformatted_dates)
		formatted_dates = unformatted_dates.map { |d| d.strftime("%d/%m/%Y") }
		return formatted_dates.to_set
	end
end
