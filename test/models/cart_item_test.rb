require "test_helper"

class CartItemTest < ActiveSupport::TestCase
  test "cart_item fixture is valid" do
    assert cart_items(:one).valid?
  end
end
