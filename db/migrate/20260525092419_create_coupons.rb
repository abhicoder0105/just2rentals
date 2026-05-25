class CreateCoupons < ActiveRecord::Migration[8.1]
  def change
    create_table :coupons do |t|
      t.string :code
      t.text :description
      t.string :discount_type
      t.decimal :value, precision: 8, scale: 2
      t.date :starts_on
      t.date :ends_on
      t.boolean :active, default: true
      t.integer :usage_limit, default: 0
      t.integer :used_count, default: 0

      t.timestamps
    end

    add_index :coupons, :code, unique: true
    add_index :coupons, :active
  end
end
