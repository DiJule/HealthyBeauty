class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_one :payment, dependent: :destroy

  validates :status, inclusion: { in: %w[pending confirmed shipped delivered canceled] }
  validates :delivery_option, presence: { message: "Виберіть спосіб доставки" }
  validates :delivery_type, presence: { message: "Виберіть тип доставки" }
  validates :delivery_method, presence: { message: "Введіть деталі доставки" }
  validates :payment_method, presence: { message: "Виберіть спосіб оплати" }, inclusion: { in: %w[cash card liqpay], message: "Виберіть спосіб оплати" }

  validates :contact_name, presence: { message: "Введіть імʼя отримувача" }
  validates :contact_phone, presence: { message: "Введіть номер телефону" }, format: { with: /\A[\d\s\-\+\(\)]+\z/, message: "Номер телефону може містити лише цифри та символи: +, -, ( )" }
  validates :contact_email, presence: { message: "Введіть email" }, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Email має неправильний формат" }

  after_create :reduce_product_stock

  private

  def reduce_product_stock
    order_items.each do |item|
      item.product.update(stock: item.product.stock - item.quantity)
    end
  end
end
