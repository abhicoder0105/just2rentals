class CreateNotifications < ActiveRecord::Migration[8.1]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :body
      t.string :kind
      t.datetime :read_at

      t.timestamps
    end

    add_index :notifications, :kind
    add_index :notifications, :read_at
  end
end
