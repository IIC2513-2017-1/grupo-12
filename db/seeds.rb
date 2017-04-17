# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(firstname: 'Vicente', lastname: 'Fuenzalida',
             email: 'vjfuenzalida@uc.cl', birthdate: Date.parse('13-10-1994'),
             password: '123123', password_confirmation: '123123')

User.create(firstname: 'Juan Pablo', lastname: 'Jofré', email: 'jbjofre@uc.cl',
            birthdate: Date.parse('28-5-1994'),
            password: '123123', password_confirmation: '123123')

15.times do |n|
  firstname = Faker::Name.unique.first_name
  lastname = Faker::Name.unique.last_name
  birthday = Faker::Date.birthday(18, 45)
  email = "mail-#{n + 1}@mail.com"
  password = '123123'
  User.create!(firstname: firstname, lastname: lastname, email: email,
               password: password, birthdate: birthday,
               password_confirmation: password)
end
