class CreateShoppings < ActiveRecord::Migration[6.0]
  def change
    create_table :shoppings do |t|

      t.decimal :num, null: false, precision: 5, scale: 3
      t.references :food, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
