class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = current_user.cart || current_user.create_cart
  end

  def clear
    current_user.cart.cart_items.destroy_all
    redirect_to cart_path, notice: "Корзина очищена"
  end
end
