require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "valid user" do
    user = User.new(email: "test@example.com", password: "password", role: 0)
    assert user.valid?
  end

  test "admin role" do
    user = User.new(email: "admin@example.com", password: "password", role: 1)
    assert user.admin?
  end
end
