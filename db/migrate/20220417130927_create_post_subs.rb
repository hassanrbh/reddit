class CreatePostSubs < ActiveRecord::Migration[7.0]
  def change
    create_table :post_subs do |t|
      t.string :sub_id, :null => false
      t.string :post_id, :null => false

      t.timestamps
    end
    add_index :post_subs, :sub_id
    add_index :post_subs, :post_id
  end
end
