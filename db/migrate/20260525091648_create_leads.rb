class CreateLeads < ActiveRecord::Migration[8.1]
  def change
    create_table :leads do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :trip_location
      t.string :preferred_vehicle
      t.string :source
      t.string :status
      t.string :priority
      t.date :follow_up_on
      t.decimal :budget, precision: 10, scale: 2
      t.text :notes

      t.timestamps
    end

    add_index :leads, :status
    add_index :leads, :priority
    add_index :leads, :follow_up_on
  end
end
