class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title, :null => false
      t.string :url
      t.text :content
      t.integer :sub_id
      t.integer :author_id 

      t.timestamps
    end
    add_index :posts, :sub_id
    add_index :posts, :author_id
  end
end
