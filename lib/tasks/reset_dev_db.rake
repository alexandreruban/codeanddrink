desc 'This task will reset development database for test purpose'
task :reset_dev_db do
  Round.update_all(state: 'not started')
  Player.update_all(status: 'alive')
  Attempt.destroy_all
  Round.first.update(number_of_winners: 3)
  Round.last.update(number_of_winners: 1)
end
