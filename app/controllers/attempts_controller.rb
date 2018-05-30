require 'open3'
require 'fileutils'

class AttemptsController < ApplicationController
  skip_before_action :authenticate_game_master!

  def create
    @exitstatus = -1
    @round = Round.find(params[:round_id])
    @player = Player.find(params[:player_id])
    @attempt = Attempt.new(attempt_params)
    @attempt.round = @round
    @attempt.player = @player
    @attempt.status = @exitstatus
    if @attempt.save
      dir_path = "#{Dir.tmpdir}/attempt_#{@attempt.id}"
      FileUtils.rm_r(dir_path) if Dir.exist?(dir_path)
      if Dir.mkdir(dir_path)
        create_attempt_file(dir_path, @attempt)
        create_rspec_file(dir_path, @round.exercise)
        run_rake(dir_path)
        @attempt.status = @exitstatus
        @attempt.save
      end
    end
    redirect_to game_player_path(@player.game, @player)
  end

  private

  def attempt_params
    params.require(:attempt).permit(:player_input)
  end

  def run_rake(path)
    @exitstatus = -1
    Timeout.timeout(20) do
      Open3.popen2e('rspec', chdir: path) do |_stdin, _stdout_and_stderr, wait_thr|
        #@output = stdout_and_stderr.readlines
        @exitstatus = wait_thr.value.exitstatus
      end
    end
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
