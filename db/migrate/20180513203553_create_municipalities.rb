class CreateMunicipalities < ActiveRecord::Migration[5.2]
  def change
    create_table :municipalities do |t|
      t.text :name, null: false
      t.text :city, null: false
      t.text :state, null: false

      t.timestamps
    end

    add_index :municipalities, :name
  end
end

