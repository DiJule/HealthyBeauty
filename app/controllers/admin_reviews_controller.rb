class AdminReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  def index
    @reviews = Review.includes(:product, :user).order(created_at: :desc)
  end

  private

  def require_admin
    unless current_user&.admin?
      redirect_to root_path, alert: "Доступ лише для адміністратора."
    end
  end
end
