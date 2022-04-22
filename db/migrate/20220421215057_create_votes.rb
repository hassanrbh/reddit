class CreateVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :votes do |t|
      t.integer :value, :null => false
      t.references :votable, :null => false, :polymorphic => true
      t.integer :user_id, :null => false
      t.timestamps
    end
    add_index :votes, :user_id
    add_index :votes, [:votable_id, :votable_type]
    add_index :votes, [:user_id, :votable_type, :votable_id], unique: true
  end
end
