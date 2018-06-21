class AddUserIdToViolations < ActiveRecord::Migration[5.2]
  def change
    add_column :violations, :user_id, :integer, null: false
    add_index :violations, :user_id

    add_foreign_key :violations, :users, name: :violations_user_id_fk
  end
end

