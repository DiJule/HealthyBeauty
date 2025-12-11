class ChangeUserRoleToEnum < ActiveRecord::Migration[7.2]
  def up
    change_column :users, :role, :integer, default: 0, null: false
    User.reset_column_information
    User.where(role: nil).update_all(role: 0)
  end

  def down
    change_column :users, :role, :string
  end
end
