class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    cart = current_user.cart || current_user.create_cart
    item = cart.cart_items.find_or_initialize_by(product_id: params[:product_id])
    item.quantity = (item.quantity || 0) + 1
    item.save

    redirect_to cart_path, notice: "Товар додано до корзини"
  end

  def update
    item = current_user.cart.cart_items.find(params[:id])
    item.update(quantity: params[:quantity])
    redirect_to cart_path
  end

  def destroy
    item = current_user.cart.cart_items.find(params[:id])
    item.destroy
    redirect_to cart_path
  end
end
