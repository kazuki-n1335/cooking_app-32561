class CreateRecipeTags < ActiveRecord::Migration[6.0]
  def change
    create_table :recipe_tags do |t|

      t.string :tag
      t.timestamps
    end
    add_index :recipe_tags, :tag, unique: true
  end
end
