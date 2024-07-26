module ApplicationHelper

	def time_conversion(minutes)
		hours = minutes / 60
		rest = minutes % 60
		return "#{hours} Hr #{rest} Min"
	end
end
