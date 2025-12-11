class ActivityLog < ApplicationRecord
  belongs_to :user, optional: true

  # simple helper to parse stored params
  def parsed_params
    JSON.parse(params || '{}') rescue {}
  end
end
