require 'test_helper'

class RoundTest < ActiveSupport::TestCase
  def setup
    @round = rounds(:round)
  end

  test "round state should be in [ 'not started', 'running', 'finished' ]" do
    [ 'not started', 'running', 'finished' ].each do |state|
      @round.state = state
      assert @round.valid?
    end
    @round.state = nil
    assert_not @round.valid?
    @round.state = "not valid"
    assert_not @round.valid?
  end
end
