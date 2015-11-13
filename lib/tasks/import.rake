require 'csv'

desc "Import listings from csv file"
task :import => [:environment] do

  file = "db/listings.csv"

  CSV.foreach(file, :headers => true) do |row|
    Listing.create(
      :street => row[1],
      :status => row[2],
      :price => row[3],
      :bedrooms => row[4],
      :bathrooms => row[5],
      :sq_ft => row[6],
      :lat => row[7],
      :lng => row[8]
    )
  end

end