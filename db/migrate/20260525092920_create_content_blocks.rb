class CreateContentBlocks < ActiveRecord::Migration[8.1]
  def change
    create_table :content_blocks do |t|
      t.string :key
      t.string :title
      t.text :body
      t.string :image_url
      t.boolean :active, default: true
      t.string :placement

      t.timestamps
    end

    add_index :content_blocks, :key, unique: true
    add_index :content_blocks, :placement
    add_index :content_blocks, :active
  end
end
