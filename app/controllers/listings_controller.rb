class ListingsController < ApplicationController
	
	# to generate geoson
	require 'rgeo/geo_json'

	def index
		# if params exist and the params are valid, perform the work
		if (listing_params!=nil) && params_checked(listing_params)
			# getting the required filters from database
			@listing = Listing.set_listing(listing_params)
			# initialize cartesian.factory for creating a point
			factory2 = RGeo::Cartesian.factory
			# create an object of factory geojson
			factory = RGeo::GeoJSON::EntityFactory.instance
			# initialize a feature array to be put in feature_collection
			features = Array.new
			#for every resulting object, perform the work
		  	@listing.each do |lst|
		  		# initialize factory point of the latitude and longitude
			  	point = factory2.point(lst.lat, lst.lng)
			  	# create an object of factory from the current listing
			  	feature1 = factory.feature(point, nil, {id: lst.id, price: lst.price, street: lst.street, bedrooms: lst.bedrooms, bathrooms: lst.bathrooms, sq_ft: lst.sq_ft})
			  	# append to feature array
			  	features.push(feature1)
			end
			# initialize the feature_collection of array features (the objects that have been inserted)
		  	feature = factory.feature_collection(features)
		  	# encode the array of features objects
		  	geo = RGeo::GeoJSON.encode(feature)
		  	# render the geojson
		  	render json: geo	
		else #if not, render error text
			render text: "Require correct filters to identify which object to return."
		end
	end

	# to manage the permitted params
	def listing_params
     	params.permit(:min_price, :max_price, :min_bed, :max_bed, :min_bath, :max_bath)
    end

    # check whether the params is valid or not
    def params_checked(params)
    	params.each do |key, value|
    		if !is_number?(value)
    			return false
    		end
    	end
    	return true
    end

    # function for determining whether a variable is an integer or not
    def is_number? string
  		true if Float(string) rescue false
	end
end
