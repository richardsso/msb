# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Match.delete_all if Rails.env.development?
User.delete_all if Rails.env.development?

levels = %w(Beginner Intermediate Advanced)

puts "Creating users..."

20.times do
  user = User.new(
    name: Faker::Sports::Football.player,
    email: Faker::Internet.email,
    password: '123456',
    address: Faker::Address.full_address,
    city: Faker::Address.city,
    gender: Faker::Gender.binary_type,
    bio: "#{Faker::Quotes::Shakespeare.as_you_like_it_quote} #{Faker::Quotes::Shakespeare.hamlet_quote}"
  )
  user.save!
end

puts "Created #{User.count} users!"


puts "Creating matches..."

10.times do

  users = User.all.ids
  teams = [2, 4, 6, 8]
  players = teams.sample

  match = Match.new(
    date: Faker::Date.forward(days: 23),
    location: Faker::Address.full_address,
    description: Faker::Sports::Football.competition,
    time: Faker::Time.between(from: DateTime.now - 12, to: DateTime.now),
    level: levels.sample,
    number_of_players: players,
    status: 'open',
    score: 0,
    team_a: users.pop(players / 2),
    team_b: users.pop(players / 2),
    user_id: User.all.sample.id)
  match.save!
end

puts "Created #{Match.count} matches!"
