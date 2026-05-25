class CreateReservations < ActiveRecord::Migration[8.1]
  def change
    create_table :reservations do |t|
      t.references :vehicle, null: false, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :pickup_location
      t.string :dropoff_location
      t.date :pickup_date
      t.date :dropoff_date
      t.string :pickup_time
      t.string :dropoff_time
      t.integer :driver_age
      t.string :protection_plan
      t.text :extras
      t.string :status
      t.string :confirmation_code
      t.decimal :total_price, precision: 10, scale: 2
      t.text :notes

      t.timestamps
    end

    add_index :reservations, :confirmation_code, unique: true
  end
end
