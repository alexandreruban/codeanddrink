require 'fileutils'
require 'open3'

class ValidateAttemptService
  def initialize(attempt)
    @attempt = attempt
    @dir_path = "#{Dir.tmpdir}/attempt_#{@attempt.id}"
  end

  def call
    if create_dir && create_attempt_file && create_rspec_file
      status, lines = run_rspec
      delete_dir
      @attempt.status = status == 0 ? "valid" : "invalid"
      @attempt.spec_output = lines.join
      @attempt.save
      ActionCable.server.broadcast "games", {
        tests_partial: ApplicationController.renderer.render(
          partial: "players/spec_output",
          locals: { attempt: @attempt }
        )
      }
      if status == 0
        @attempt.round.add_valid_attempt(@attempt)
      end

    end
  end

  private

  def create_dir
    delete_dir
    Dir.mkdir(@dir_path)
  end

  def delete_dir
    FileUtils.rm_r(@dir_path) if Dir.exist?(@dir_path)
  end

  def create_attempt_file
    if Dir.mkdir("#{@dir_path}/lib")
      open("#{@dir_path}/lib/attempt.rb", "w") do |f|
        f << @attempt.player_input
      end
    end
  end

  def create_rspec_file
    if Dir.mkdir("#{@dir_path}/spec")
      open("#{@dir_path}/spec/attempt_spec.rb", "w") do |f|
        f << @attempt.round.exercise.specs
      end
    end
  end

  def run_rspec
    Timeout.timeout(20) do
      Open3.popen2e('rspec', chdir: @dir_path) do |_stdin, stdout_and_stderr, wait_thr|
        return wait_thr.value.exitstatus, stdout_and_stderr.readlines
      end
    end
  end
end
