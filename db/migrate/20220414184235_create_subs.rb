class CreateSubs < ActiveRecord::Migration[7.0]
  def change
    create_table :subs do |t|
      t.string :title, :null => false, :limit => 100
      t.string :description, :null => false, :limit => 500
      t.integer :moderator_id, :null => false
      
      t.timestamps
    end
    add_index :subs, :title
    add_index :subs, :moderator_id
  end
end
