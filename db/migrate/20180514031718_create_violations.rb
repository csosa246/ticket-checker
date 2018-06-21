class CreateViolations < ActiveRecord::Migration[5.2]
  def change
    create_table :violations do |t|
      t.integer :municipality_id, null: false
      t.integer :violation_id, null: false
      t.integer :amount, null: false
      t.text :status
      t.text :description

      t.timestamps
    end

    add_index :violations, :municipality_id
    add_foreign_key :violations, :municipalities, name: 'violations_municipalities_id_fk'
  end
end

