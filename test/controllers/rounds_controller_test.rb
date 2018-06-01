require 'test_helper'

class RoundsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @round = rounds(:round)
    @later_round = rounds(:later_round)
    @latest_round = rounds(:latest_round)
  end

  test "rounds should be valid" do
    assert @round.valid?
    assert @later_round.valid?
    assert @latest_round.valid?
  end

  test "rounds should be in order created at desc" do
    assert_equal Round.all.last, @latest_round
    assert_equal Round.all.first, @round
  end
end
