require 'test_helper'

class GameTest < ActiveSupport::TestCase
  def setup
    @game = games(:game)
  end

  test "game should be valid" do
    assert @game.valid?
  end

  test "game should have a game_master_id" do
    @game.game_master_id = nil
    assert_not @game.valid?
  end
end
