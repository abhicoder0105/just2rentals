class AddUserAndBookingControlsToReservations < ActiveRecord::Migration[8.1]
  def change
    add_reference :reservations, :user, null: true, foreign_key: true
    add_reference :reservations, :coupon, null: true, foreign_key: true
    add_column :reservations, :cancelled_at, :datetime
    add_column :reservations, :cancellation_reason, :text
    add_column :reservations, :invoice_number, :string
    add_column :reservations, :pricing_snapshot, :text
    add_index :reservations, :invoice_number, unique: true
  end
end
