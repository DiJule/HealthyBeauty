require "test_helper"

class DeliveryOptionTest < ActiveSupport::TestCase
  test "delivery_option fixture is valid" do
    assert delivery_options(:one).valid?
  end
end
