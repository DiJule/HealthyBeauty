class AddAiFieldsToProducts < ActiveRecord::Migration[7.2]
  def change
    add_column :products, :characteristics, :text
    add_column :products, :benefits, :text
    add_column :products, :usage, :text
  end
end
