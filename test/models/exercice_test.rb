require 'test_helper'

class ExerciceTest < ActiveSupport::TestCase
  def setup
    @exercise = exercises(:exercise)
  end

  test "exercise should be valid" do
    assert @exercise.valid?
  end
end
