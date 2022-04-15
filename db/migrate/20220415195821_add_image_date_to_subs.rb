class AddImageDateToSubs < ActiveRecord::Migration[7.0]
  def change
    add_column :subs, :image_date, :text
  end
end
