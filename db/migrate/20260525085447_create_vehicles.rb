class CreateVehicles < ActiveRecord::Migration[8.1]
  def change
    create_table :vehicles do |t|
      t.string :name
      t.string :make
      t.string :model
      t.integer :year
      t.string :category
      t.integer :seats
      t.integer :doors
      t.string :transmission
      t.string :fuel
      t.string :drivetrain
      t.string :location
      t.decimal :daily_rate, precision: 8, scale: 2
      t.decimal :rating, precision: 3, scale: 1
      t.string :image_url
      t.string :hero_color
      t.string :mileage
      t.integer :luggage
      t.boolean :featured, default: false
      t.boolean :available, default: true
      t.text :description

      t.timestamps
    end

    add_index :vehicles, :category
    add_index :vehicles, :location
    add_index :vehicles, :daily_rate
  end
end
