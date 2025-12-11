class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product

  def create
    @review = @product.reviews.new(review_params)
    @review.user = current_user
    if @review.save
      redirect_to @product, notice: "Відгук додано!"
    else
      redirect_to @product, alert: "Помилка! Перевірте дані."
    end
  end

  def destroy
    @review = @product.reviews.find(params[:id])
    if @review.user == current_user || current_user.admin?
      @review.destroy
      redirect_to @product, notice: "Відгук видалено!"
    else
      redirect_to @product, alert: "Ви не маєте прав!"
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
