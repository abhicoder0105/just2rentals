class CreatePayments < ActiveRecord::Migration[8.1]
  def change
    create_table :payments do |t|
      t.references :reservation, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.decimal :amount, precision: 10, scale: 2
      t.string :status, default: "Pending"
      t.string :provider
      t.string :transaction_id
      t.datetime :paid_at
      t.text :metadata

      t.timestamps
    end

    add_index :payments, :status
    add_index :payments, :transaction_id, unique: true
  end
end
