class AddUserIdToTickets < ActiveRecord::Migration[5.2]
  def change
    add_column :tickets, :user_id, :integer, null: false
    add_index :tickets, :user_id

    add_foreign_key :tickets, :users, name: :tickets_user_id_fk
  end
end

