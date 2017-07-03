srand(100)

# USER CREATION

u = User.create(firstname: 'Vicente', lastname: 'Fuenzalida',
             email: 'vjfuenzalida@uc.cl', birthdate: Date.parse('13-10-1994'),
             password: '123123', password_confirmation: '123123',
             activated: true, activated_at: Time.zone.now)

uu = User.create(firstname: 'Juan Pablo', lastname: 'Jofré', email: 'jbjofre@uc.cl',
            birthdate: Date.parse('28-5-1994'),
            password: '123123', password_confirmation: '123123',
            activated: true, activated_at: Time.zone.now)
u.generate_token_and_save
uu.generate_token_and_save
# Total: 27 users

# CATEGORIES

categories = %w[Art Comics Crafts Dance Design Fashion Film\ &\ Video Food Games Journalism Music Photography Publishing Technology Theater]
categories.each do |category|
  Category.create!(name: category)
end
cats = Category.count

25.times do |n|
  firstname = Faker::Name.unique.first_name
  lastname = Faker::Name.unique.last_name
  birthday = Faker::Date.birthday(18, 45)
  email = "mail-#{n + 1}@mail.com"
  password = '123123'
  n = User.create!(firstname: firstname, lastname: lastname, email: email,
               password: password, birthdate: birthday,
               password_confirmation: password, activated: true,
               activated_at: Time.zone.now)
  n.generate_token_and_save
end

# PROJECT CREATION

file = File.read(File.join(Rails.root, 'db', 'kickstarter_data.json'))
data = JSON.parse(file)

num = User.count
25.times do |n|
  # description = Faker::Hipster.paragraph
  # brief = "Project #{n + 1}: #{Faker::LordOfTheRings.location}"
  brief = data[n]['brief']
  description = data[n]['description']
  user = rand(1..num).to_i
  date = Faker::Date.forward(120)
  proj = Project.create!(brief: brief,
                         description: description,
                         funding_duration: date,
                         funding_goal: rand(1..300).to_i * 1000,
                         user_id: user)
  number = rand(1..3).to_i
  number.times do
    categ = rand(1..cats).to_i
    proj.add_category(Category.find(categ))
  end
end

## Users follow other users and projects

User.all.each do |user|
  arr = (1..num).to_a.map(&:to_i).shuffle.take(rand(0..8).to_i) - [user.id]
  arr.each { |followed| user.follow(User.find(followed)) }
  Project.all.sample(4).map { |e| user.save_project(e) }
  Project.all.sample(3).map { |e| Donation.create(user: user, project: e, amount: rand(5..e.funding_goal / 40)) }
end

## Random comments

40.times do |_x|
  user = User.all.sample
  project = Project.all.sample
  Comment.create(content: Faker::Hobbit.quote, user: user, project: project)
end
