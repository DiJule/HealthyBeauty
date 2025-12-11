require "test_helper"

class CartTest < ActiveSupport::TestCase
  test "cart fixture is valid" do
    assert carts(:one).valid?
  end
end
