class CreateRentalDocuments < ActiveRecord::Migration[8.1]
  def change
    create_table :rental_documents do |t|
      t.references :reservation, null: false, foreign_key: true
      t.string :document_type
      t.string :file_name
      t.string :status
      t.text :notes

      t.timestamps
    end

    add_index :rental_documents, :status
    add_index :rental_documents, :document_type
  end
end
