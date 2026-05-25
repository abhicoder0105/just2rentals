class CreateAdminInvitations < ActiveRecord::Migration[8.1]
  def change
    create_table :admin_invitations do |t|
      t.string :email
      t.string :role
      t.string :token
      t.references :invited_by, null: false, foreign_key: { to_table: :users }
      t.datetime :accepted_at
      t.datetime :expires_at

      t.timestamps
    end

    add_index :admin_invitations, :email
    add_index :admin_invitations, :token, unique: true
    add_index :admin_invitations, :role
  end
end
