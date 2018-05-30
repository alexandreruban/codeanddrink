require 'test_helper'

class AttemptTest < ActiveSupport::TestCase
  def setup
    @attempt = attempts(:attempt)
  end

  test "attempt should be valid" do
    assert @attempt.valid?
  end

  test "attempts status should be in %w[undefined pending valid invalid]" do
    %w[undefined pending valid invalid].each do |status|
      @attempt.status = status
      assert @attempt.valid?
    end
    @attempt.status = "something"
    assert_not @attempt.valid?
  end

  test "attempt default should be undefined" do
    assert_equal Attempt.new.status, "undefined"
  end
end
