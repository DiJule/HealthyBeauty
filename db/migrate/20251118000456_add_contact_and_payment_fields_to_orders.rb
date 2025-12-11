class AddContactAndPaymentFieldsToOrders < ActiveRecord::Migration[7.2]
  def change
    add_column :orders, :contact_name, :string
    add_column :orders, :contact_phone, :string
    add_column :orders, :contact_email, :string
    add_column :orders, :delivery_type, :string
    add_column :orders, :payment_method, :string
  end
end
