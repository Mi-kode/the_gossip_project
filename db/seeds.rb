# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

# Clear all
Like.destroy_all
Comment.destroy_all
Tag.destroy_all
Gossip.destroy_all
User.destroy_all
City.destroy_all

puts "Seeding cities..."
# Create City
cities = 10.times.map do
    City.create!(
        name: Faker::Address.city,
        zip_code: Faker::Address.zip_code
    )
end

puts "Seeding users..."
# Create Users
users = 10.times.map do
    User.create!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        description: Faker::Quote.famous_last_words,
        email: Faker::Internet.email,
        age: rand(18..28),
        city: cities.sample
    )
end

puts "Seeding gossips..."
# Create Gossip
gossips = 20.times.map do
    Gossip.create!(
        title: Faker::Lorem.sentence(word_count: 3),
        content: Faker::Lorem.paragraph,
        user: users.sample
    )
end

puts "Seeding tags..."
# Create Tag
tags = 10.times.map do
    Tag.create!(
        title: Faker::Lorem.words(number: 2).join(" ")
    )
end

puts "Linking gossips to tags..."
# Add tags to gossips
gossips.each do |gossip|
    gossip.tags << tags.sample(rand(1..3))
end