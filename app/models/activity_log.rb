class ActivityLog < ApplicationRecord
  belongs_to :user, optional: true

  def parsed_params
    JSON.parse(params || '{}') rescue {}
  end
end
