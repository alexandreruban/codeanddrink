desc 'This task will reset development database for test purpose'
task :reset_dev_db do
  Round.update_all(state: 'not started')
  Player.update_all(status: 'alive')
end

# Player.find_by(username: "Lulu").update(status: "alive")

