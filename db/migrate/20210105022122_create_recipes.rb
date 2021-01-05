class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|

      t.string :title, null: false
      t.integer :people, null: false
      t.text :food, null: false
      t.text :making, null: false
      t.text :introduce
      t.boolean :release, default: false, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
