# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require 'set'

week_days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

User.create!(name: "Sergio",
             surname: "Martínez de Tejada",
             password: "admin45",
             password_confirmation: "admin45",
             email: "sergimartnez@yahoo.es")


50.times do |n|
  name  = Faker::Name.first_name
  surname = Faker::Name.last_name
  email = Faker::Internet.email
  password = Faker::Internet.password(8, 8)
  password_confirmation = password
  new_user = User.create!(name: name,
                   surname: surname,
                   password: password,
                   password_confirmation: password_confirmation,
                   email: email)

  space_type = Space::TYPES.sample
  user = new_user
  longitude = Faker::Number.between(from = 41.28, to = 41.72)
  latitude = Faker::Number.between(from = 1.91, to = 2.22)
  new_search = Search.create!(space_type: space_type,
  							 user: user,
                 longitude: longitude,
                 latitude: latitude)

	search = new_search
	start_hour = Faker::Number.between(0, 23)
  start_minute = 0
  end_hour = Faker::Number.between(start_hour + 1, 23)
  end_minute = 0
  week_array = []

  7.times do |i|
    week_array.push(AppOperations.get_day_array_of_desired_times(start_hour, end_hour))
  end
  new_search.store_array_of_desired_times week_array

  #Create 2 spaces per user
  type_of_space = Space::TYPES.sample
  new_garage = Space.create!(type_of_space: type_of_space,
                    user: user)
end

40.times do |n|
  name  = Faker::Name.first_name
  surname = Faker::Name.last_name
  email = Faker::Internet.email
  password = Faker::Internet.password(8, 8)
  password_confirmation = password
  new_user = User.create!(name: name,
               surname: surname,
               password: password,
               password_confirmation: password_confirmation,
               email: email)

  space_type = Space::TYPES.sample
  user = new_user
  longitude = Faker::Number.between(from = 40.34, to = 40.52)
  latitude = Faker::Number.between(from = -3.73, to = -3.65)
  new_search = Search.create!(space_type: space_type,
                 user: user,
                 longitude: longitude,
                 latitude: latitude)
  week_array = []
  7.times do |i|
    random_var = Faker::Number.between(0, 1)
    
    if random_var == 0
      search = new_search
      week_day = week_days[i]
      start_hour = Faker::Number.between(0, 23)
      end_hour = Faker::Number.between(start_hour + 1, 23)
         
    else
      search = new_search
      week_day = week_days[i]
      start_hour = nil
      end_hour = nil
    end
    week_array.push(AppOperations.get_day_array_of_desired_times(start_hour, end_hour))
  end
  new_search.store_array_of_desired_times week_array
end



