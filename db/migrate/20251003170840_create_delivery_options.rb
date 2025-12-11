class CreateDeliveryOptions < ActiveRecord::Migration[7.2]
  def change
    create_table :delivery_options do |t|
      t.string :name
      t.decimal :price

      t.timestamps
    end
  end
end
