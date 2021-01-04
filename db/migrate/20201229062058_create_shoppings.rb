class CreateShoppings < ActiveRecord::Migration[6.0]
  def change
    create_table :shoppings do |t|

      t.string :num
      t.string :name, null: false
      t.integer :category_id, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
