class User < ApplicationRecord
  # Devise authentication
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { user: 0, admin: 1 }, _default: :user

  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :feedbacks, dependent: :destroy

  validates :email, presence: true

  def admin?
    role == "admin"
  end
end
