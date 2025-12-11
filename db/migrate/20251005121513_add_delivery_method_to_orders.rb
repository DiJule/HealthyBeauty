class AddDeliveryMethodToOrders < ActiveRecord::Migration[7.2]
  def change
    add_column :orders, :delivery_method, :string
  end
end
