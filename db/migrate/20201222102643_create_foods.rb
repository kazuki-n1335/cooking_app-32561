class CreateFoods < ActiveRecord::Migration[6.0]
  def change
    create_table :foods do |t|

      t.string :name,       null: false, unique: true
      t.integer :food_tag_id, null: false
      t.integer :time
      t.integer :unit_id,       null: false
      t.timestamps
    end
  end
end
