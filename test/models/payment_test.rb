require "test_helper"

class PaymentTest < ActiveSupport::TestCase
  test "payment fixture is valid" do
    assert payments(:one).valid?
  end
end
