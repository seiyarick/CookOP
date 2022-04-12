class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|

      t.timestamps
      t.integer :dish_id
      t.integer :user_id
      t.text :comment_text
      t.integer :comment_count
    end
  end
end
