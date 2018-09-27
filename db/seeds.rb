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
    user['gender'] = Faker::Gender.binary_type
    user['phone'] = Faker::PhoneNumber.phone_number
    user['country'] = Faker::Address.country
    user['birthdate'] = Faker::Date.between(50.years.ago, Date.today)
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
    listing['property_title'] = ["House", "Entire Floor", "Condominium", "Villa", "Townhouse",
      "Castle", "Treehouse", "Igloo", "Yurt", "Cave", "Chalet", "Hut", "Tent", "Other"].sample
    listing['price'] = rand(80..500)
    listing['location'] = Faker::Address.state
    listing['description'] = Faker::Hipster.sentence

    listing['room_number'] = rand(0..5)
    listing['bed_number'] = rand(1..6)
    listing['guest_number'] = rand(1..10)

    listing['country'] = Faker::Address.country
    listing['state'] = ["Kuala Lumpur", "Seleangor", "Negeri Sembilan", "Kedah",
      "Perak", "Penang", "Perlis", "Kelantan", "Sabah", "Sarawak", "Johor", "Terrenganu"].sample
    listing['city'] = Faker::Address.city
    listing['zipcode'] = Faker::Address.zip_code
    listing['address'] = Faker::Address.street_address

    listing['user_id'] = uids.sample

    Listing.create(listing)
  end
end
