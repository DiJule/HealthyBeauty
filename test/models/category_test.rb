require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  test "category fixture is valid" do
    assert categories(:one).valid?
  end
end
