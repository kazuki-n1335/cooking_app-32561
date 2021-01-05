class RecipeTag < ApplicationRecord
  has_many :recipes, through: recipe_tag_relations
  has_many :recipe_tag_relations, dependent: :destroy

end
