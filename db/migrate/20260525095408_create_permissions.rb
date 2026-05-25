class CreatePermissions < ActiveRecord::Migration[8.1]
  def change
    create_table :permissions do |t|
      t.string :key
      t.text :description
      t.string :category

      t.timestamps
    end

    add_index :permissions, :key, unique: true
    add_index :permissions, :category
  end
end
