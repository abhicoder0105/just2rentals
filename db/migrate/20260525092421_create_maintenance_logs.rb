class CreateMaintenanceLogs < ActiveRecord::Migration[8.1]
  def change
    create_table :maintenance_logs do |t|
      t.references :vehicle, null: false, foreign_key: true
      t.string :status
      t.string :service_type
      t.date :scheduled_on
      t.date :completed_on
      t.decimal :cost, precision: 10, scale: 2
      t.integer :odometer
      t.text :notes

      t.timestamps
    end

    add_index :maintenance_logs, :status
    add_index :maintenance_logs, :scheduled_on
  end
end
