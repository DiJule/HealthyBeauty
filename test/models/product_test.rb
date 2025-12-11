require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "valid product" do
    category = Category.create!(name: "TestCat")
    product = Product.new(name: "Test", price: 10, stock: 5, category: category)
    assert product.valid?
  end
end
