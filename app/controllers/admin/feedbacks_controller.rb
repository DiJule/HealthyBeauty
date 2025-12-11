class Admin::FeedbacksController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin!

  def index
    @feedbacks = Feedback.all.order(created_at: :desc)
  end

  private

  def check_admin!
    redirect_to root_path, alert: "Нема доступу" unless current_user.admin?
  end
end
