require 'json'
require 'pry'
require 'time'

# Method to reat the input data
def read_json(path)
  file = File.read(path)
  data_hash = JSON.parse(file)
end

# Method to do some calculus

def multiply(a,b)
  return a*b
end

def sum(a,b)
  return a+b
end

# Method to get the number of days that occured
# between start and end date
def delta_date(first_date, second_date)
 delta =Time.parse(second_date) - Time.parse(first_date)
 delta = (delta /86400 +1).to_i
end

# Method to create a new hash
def create_output_hash
  output_hash = Hash.new
end
# Method to create a new tab

def create_output_tab
  output_tab = []
end


# Method to write a json
def write_json (path, output)

  File.open(path,"w") do |f|
    f.write(JSON.pretty_generate(output))
  end
end

# Getting the input
data_hash = read_json('data/input.json')

cars_hash = data_hash["cars"]
rental_hash = data_hash["rentals"]
#Creating a tab to get the data
output_tab = create_output_tab

#Going through the hash using a loop
rental_hash.each do |rental|

#defining the index
i = rental["car_id"] -1

 #Get the relevent information
 cars_rented_data = cars_hash[i]
 price_per_km = cars_rented_data["price_per_km"]
 distance_achieved = rental["distance"]

#Calculating days rented
days_rented = delta_date(rental["start_date"], rental["end_date"])


#Defining Kilometric prices
price_distance_achieved = multiply(distance_achieved , price_per_km)

#Day rented

price_day_rented = multiply(days_rented , cars_rented_data["price_per_day"])

output_tab << { "id" => rental["id"], "price" => sum(price_day_rented , price_distance_achieved)}
end

output_hash = create_output_hash
output_hash["rental"] = output_tab

write_json("data/output.json", output_hash)





