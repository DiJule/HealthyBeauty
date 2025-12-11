require "test_helper"

class ReviewTest < ActiveSupport::TestCase
  test "review fixture is valid" do
    assert reviews(:one).valid?
  end
end
