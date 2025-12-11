class Feedback < ApplicationRecord
  belongs_to :user

  validates :message, presence: true, length: { minimum: 5 }
end
