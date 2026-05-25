class AddAdminReviewFieldsToReservations < ActiveRecord::Migration[8.1]
  def change
    add_column :reservations, :deposit_amount, :decimal, precision: 10, scale: 2
    add_column :reservations, :deposit_status, :string, default: "Pending"
    add_column :reservations, :document_status, :string, default: "Pending review"
    add_column :reservations, :admin_notes, :text
    add_column :reservations, :reviewed_at, :datetime
    add_column :reservations, :reviewed_by, :string

    add_index :reservations, :status
    add_index :reservations, :deposit_status
    add_index :reservations, :document_status
  end
end
