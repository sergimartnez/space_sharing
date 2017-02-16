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
             password: "Andalucia45",
             password_confirmation: "Andalucia45",
             email: "sergimartnez@yahoo.es")

10.times do |n|
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

  space_type = "Garage"
  user = new_user
  new_search = Search.create!(space_type: space_type,
  							 user: user)

	search = new_search
	start_hour = Faker::Number.between(0, 23)
  start_minute = 0
  end_hour = Faker::Number.between(start_hour + 1, 23)
  end_minute = 0
  7.times do |i|
    week_day = week_days[i]
  	day_search = DaySearchItem.create!(search: search,
                          week_day: week_day, 
                          start_hour: start_hour, 
                          start_minute: start_minute,
                          end_hour: end_hour,
                          end_minute: end_minute)

    day_search.store_day_array_of_desired_times
  end
  new_search.store_array_of_desired_times
end

5.times do |n|
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

  space_type = "Garage"
  user = new_user
  new_search = Search.create!(space_type: space_type,
                 user: user)

  7.times do |i|
    random_var = Faker::Number.between(0, 1)
    if random_var == 0
      search = new_search
      week_day = week_days[i]
      start_hour = Faker::Number.between(0, 23)
      start_minute = 0
      end_hour = Faker::Number.between(start_hour + 1, 23)
      end_minute = 0
      day_search = DaySearchItem.create!(search: search,
                            week_day: week_day, 
                            start_hour: start_hour, 
                            start_minute: start_minute,
                            end_hour: end_hour,
                            end_minute: end_minute)
     
    else
      search = new_search
      week_day = week_days[i]
      start_hour = nil
      start_minute = nil
      end_hour = nil
      end_minute = nil
      day_search = DaySearchItem.create!(search: search,
                            week_day: week_day, 
                            start_hour: start_hour, 
                            start_minute: start_minute,
                            end_hour: end_hour,
                            end_minute: end_minute)
    end

    day_search.store_day_array_of_desired_times
  end
  new_search.store_array_of_desired_times
end



