class CreateFavorits < ActiveRecord::Migration[5.2]
  def change
    create_table :favorits do |t|

      t.timestamps
      t.integer :user_id
      t.integer :dish_id
      t.integer :favorits_count
      
    end
  end
end
