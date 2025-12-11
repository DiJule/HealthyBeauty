
class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin, only: [ :index ]

  def index
    @users = User.order(created_at: :desc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Реєстрація успішна!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def require_admin
    unless current_user&.admin?
      redirect_to root_path, alert: "Доступ лише для адміністратора."
    end
  end
end
