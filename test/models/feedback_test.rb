require "test_helper"

class FeedbackTest < ActiveSupport::TestCase
  test "feedback fixture is valid" do
    assert feedbacks(:one).valid?
  end
end
