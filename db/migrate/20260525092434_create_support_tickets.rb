class CreateSupportTickets < ActiveRecord::Migration[8.1]
  def change
    create_table :support_tickets do |t|
      t.references :user, null: false, foreign_key: true
      t.references :reservation, null: true, foreign_key: true
      t.string :subject
      t.string :status, default: "Open"
      t.string :priority, default: "Medium"
      t.string :category
      t.text :message
      t.string :assigned_to
      t.datetime :resolved_at

      t.timestamps
    end

    add_index :support_tickets, :status
    add_index :support_tickets, :priority
  end
end
