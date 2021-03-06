namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Eric Liu",
                 email: "ericliu@myart.com",
                 password: "password",
                 password_confirmation: "password")
    admin.toggle!(:admin)
    admin = User.create!(name: "Eric Liu2",
                 email: "ericliu2@myart.com",
                 password: "password",
                 password_confirmation: "password")
    admin.toggle!(:admin)
    99.times do |n|
      name  = Faker::Name.name
      email = "person-#{n+1}@myart.com"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end