class AddLicensePlateInformationToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :license_plate, :text, null: false
    add_column :users, :state, :text, null: false
    add_index :users, %i(license_plate state), unique: true
  end
end

