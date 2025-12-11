class ReplaceDeliveryOptionIdWithDeliveryOption < ActiveRecord::Migration[7.0]
  def change
    remove_column :orders, :delivery_option_id, :integer
    add_column :orders, :delivery_option, :string
  end
end
