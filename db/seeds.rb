# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

srand(100)

# USER CREATION

User.create!(firstname: 'Vicente', lastname: 'Fuenzalida',
             email: 'vjfuenzalida@uc.cl', birthdate: Date.parse('13-10-1994'),
             password: '123123', password_confirmation: '123123')

User.create(firstname: 'Juan Pablo', lastname: 'Jofré', email: 'jbjofre@uc.cl',
            birthdate: Date.parse('28-5-1994'),
            password: '123123', password_confirmation: '123123')

# Total: 27 users

25.times do |n|
  firstname = Faker::Name.unique.first_name
  lastname = Faker::Name.unique.last_name
  birthday = Faker::Date.birthday(18, 45)
  email = "mail-#{n + 1}@mail.com"
  password = '123123'
  User.create!(firstname: firstname, lastname: lastname, email: email,
               password: password, birthdate: birthday,
               password_confirmation: password)
end

# Following relationships
num = User.count
User.all.each do |user|
  arr = (1..num).to_a.map{ |e| e.to_i }.shuffle.take(rand(0..8).to_i) - [user.id]
  arr.each { |followed| user.follow(User.find(followed)) }
end

# PROJECT CREATION

12.times do |_n|
  description = Faker::Lorem.paragraph
  brief = Faker::Lorem.sentence
  user = rand(1..num).to_i
  date = Faker::Date.forward(120)
  Project.create!(brief: brief,
                  description: description,
                  funding_duration: date,
                  funding_goal: rand(1..300).to_i * 1000,
                  user_id: user)
end
