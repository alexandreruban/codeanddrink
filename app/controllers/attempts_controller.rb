class AttemptsController < ApplicationController
  skip_before_action :authenticate_game_master!

  def create
    @round = Round.find(params[:round_id])
    @player = Player.find(params[:player_id])
    @attempt = Attempt.new(attempt_params)
    @attempt.round = @round
    @attempt.player = @player
    if @attempt.save
      dir_path = "#{Dir.tmpdir}/attempt_#{@attempt.id}"
      if Dir.mkdir(dir_path)
        create_attempt_file(dir_path, @attempt)
        create_rspec_file(dir_path, @round.exercise)
        raise
      end
    end
  end

  private

  def attempt_params
    params.require(:attempt).permit(:player_input)
  end

  def create_attempt_file(dir_path, attempt)
    success = false
    if Dir.mkdir("#{dir_path}/lib")
      attempt_file = File.new("#{dir_path}/lib/attempt.rb", "w")
      if attempt_file
        attempt_file.write(attempt.player_input)
        attempt_file.close
        success = true
      end
    end
    return success
  end

  def create_rspec_file(dir_path, exercise)
    success = false
    if Dir.mkdir("#{dir_path}/spec")
      rspec_file = File.new("#{dir_path}/spec/attempt_spec.rb", "w")
      if rspec_file
        rspec_file.write(exercise.specs)
        rspec_file.close
        success = true
      end
    end
    return success
  end
end
