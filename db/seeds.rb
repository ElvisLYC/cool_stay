# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Seed Users
# Seed Users

User.create(email: Faker::Internet.email, password: "1234", full_name: Faker::Name.name)


user = {}
user['password'] = 'asdf'

ActiveRecord::Base.transaction do
  20.times do
    user['full_name'] = Faker::Name.name
    user['email'] = Faker::Internet.email
    # user['role'] = 0
    User.create(user)
  end
end

# Seed Listings
listing = {}
uids = []
User.all.each { |u| uids << u.id }

ActiveRecord::Base.transaction do
  40.times do
    listing['property_title'] = Faker::Address.city
    listing['price'] = rand(80..500)
    listing['location'] = Faker::Address.state
    listing['description'] = Faker::Hipster.sentence

    listing['user_id'] = uids.sample

    Listing.create(listing)
  end
end
