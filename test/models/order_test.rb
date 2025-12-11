require "test_helper"

class OrderTest < ActiveSupport::TestCase
  test "order fixture is valid" do
    assert orders(:one).valid?
  end
end
