class AddAvatarToSubs < ActiveRecord::Migration[7.0]
  def change
    add_column :subs, :avatar, :string
  end
end
