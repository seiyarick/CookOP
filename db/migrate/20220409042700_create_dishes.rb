class CreateDishes < ActiveRecord::Migration[5.2]
  def change
    create_table :dishes do |t|

      t.timestamps
      t.integer :user_id
      t.string :dish_name
      t.text :introduction
    end
  end
end
