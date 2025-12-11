class CreateActivityLogs < ActiveRecord::Migration[7.2]
  def change
    create_table :activity_logs do |t|
      t.integer :user_id, index: true
      t.string :path
      t.string :http_method
      t.text :params
      t.string :ip
      t.string :user_agent

      t.timestamps
    end
    add_foreign_key :activity_logs, :users, column: :user_id
  end
end
