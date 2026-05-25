class CreateAdminActions < ActiveRecord::Migration[8.1]
  def change
    create_table :admin_actions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :action
      t.string :resource_type
      t.integer :resource_id
      t.string :ip_address
      t.text :metadata

      t.timestamps
    end

    add_index :admin_actions, [:resource_type, :resource_id]
    add_index :admin_actions, :action
  end
end
