require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  def setup
    @alex = players(:alex)
    @guillaume = players(:guillaume)
    @marjorie = players(:marjorie)
  end

  test "alex should be valid" do
    assert @alex.valid?
  end

  test "player status should be in %w[alive defeated]" do
    %w[alive defeated].each do |status|
      @alex.status = status
      assert @alex.valid?
    end
    @alex.status = "something invalid"
    assert_not @alex.valid?
  end

  test "should have default status of alive" do
    assert_equal Player.new.status, "alive"
  end
end
