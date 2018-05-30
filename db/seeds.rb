# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Destroying previous data..."
Round.destroy_all
Exercise.destroy_all
Player.destroy_all
Game.destroy_all
GameMaster.destroy_all


file = "db/samples.yml"
samples = YAML.load(open(file).read)

# Create all game masters
puts "Creating game masters..."
game_masters = {}
game_master_samples = samples["game_masters"]
game_master_samples.each do |game_master_sample|
  game_masters[game_master_sample["id"]] = GameMaster.create!(game_master_sample.slice("email", "password"))
end

# Create all exercises
puts "Creating exercises..."
exercises = {}
exercise_samples = samples["exercises"]
exercise_samples.each do |exercise_sample|
  exercises[exercise_sample["id"]] = Exercise.create!(exercise_sample.slice("title", "rules", "specs", "solution"))
end

# Create all games
puts "Creating games..."
games = {}
game_samples = samples["games"]
game_samples.each do |game_sample|
  game = Game.new(game_sample.slice("title", "description", "wifi_network", "wifi_password", "starts_at", "password"))
  games[game_sample["id"]] = game
  game.game_master = game_masters[game_sample["game_master_id"]]
  game.save!
end

# Create all rounds
puts "Creating rounds..."
round_samples = samples["rounds"]
round_samples.each do |round_sample|
  round = Round.new(round_sample.slice("number_of_winners"))
  round.game = games[round_sample["game_id"]]
  round.exercise = exercises[round_sample["exercise_id"]]
  round.save!
end

# Create all players
puts "Creating players..."
player_samples = samples["players"]
player_samples.each do |player_sample|
  player = Player.new(player_sample.slice("username"))
  player.game = games[player_sample["game_id"]]
  player.save!
end

puts "Done."







