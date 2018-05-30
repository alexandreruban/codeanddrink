require 'test_helper'

class GameMasterTest < ActiveSupport::TestCase
  def setup
    @edouard = game_masters(:edouard)
  end

  test "game master should be valid" do
    assert @edouard.valid?
  end
end
