require 'fileutils'
require 'open3'

class ValidateAttemptService
  def initialize(attempt)
    @attempt = attempt
    @dir_path = "#{Dir.tmpdir}/attempt_#{@attempt.id}"
  end

  def call
    if create_dir && create_attempt_file && create_rspec_file
      status = run_rspec
      delete_dir
      if status == 0
        @attempt.status = "valid"
        @attempt.player.update(status: "alive")
        @attempt.round.winners += 1
      else
        @attempt.status = "valid"
      end
      @attempt.save
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
        stdout_and_stderr.readlines
        wait_thr.value.exitstatus
      end
    end
  end
end
