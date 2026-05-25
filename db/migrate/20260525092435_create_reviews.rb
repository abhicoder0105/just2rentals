class CreateReviews < ActiveRecord::Migration[8.1]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :vehicle, null: false, foreign_key: true
      t.references :reservation, null: true, foreign_key: true
      t.integer :rating
      t.string :title
      t.text :body
      t.boolean :approved, default: false

      t.timestamps
    end

    add_index :reviews, :approved
    add_index :reviews, :rating
  end
end
