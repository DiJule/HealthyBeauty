require "test_helper"

class OrderItemTest < ActiveSupport::TestCase
  test "order_item fixture is valid" do
    assert order_items(:one).valid?
  end
end
