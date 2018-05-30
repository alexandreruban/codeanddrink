require 'test_helper'

class GameTest < ActiveSupport::TestCase
  def setup
    @game = games(:game)
  end

  test "game should be valid" do
    assert @game.valid?
  end
end
