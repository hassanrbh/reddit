class AddSubscriptionToSubs < ActiveRecord::Migration[7.0]
  def change
    add_column :subs, :subscriptors, :integer, array: true, :default => []
  end
end
