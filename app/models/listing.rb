class Listing < ActiveRecord::Base
	def self.set_listing(params)
		
		# converting the params to Integer so it can perform range search
		min_price = params[:min_price].to_i
		max_price = params[:max_price].to_i
		min_bed = params[:min_bed].to_i
		max_bed = params[:max_bed].to_i
		min_bath = params[:min_bath].to_i
		max_bath = params[:max_bath].to_i

		# if there is no max_price in the params, initialize max_price to infinity
		if max_price == 0
			max_price = Float::INFINITY
		end

		# if there is no max_bed in the params, initialize max_price to infinity
		if max_bed == 0
			max_bed = Float::INFINITY
		end

		# if there is no max_bath in the params, initialize max_price to infinity
		if max_bath == 0
			max_bath = Float::INFINITY
		end

		# perform the query and return the result
		return Listing.where(price: (min_price..max_price), bedrooms: (min_bed..max_bed), bathrooms: (min_bath..max_bath))
	end
end
