class Payment < ApplicationRecord
  belongs_to :order

  validates :status, inclusion: { in: %w[pending paid failed] }
  validates :method, inclusion: { in: %w[cash card liqpay] }
end
