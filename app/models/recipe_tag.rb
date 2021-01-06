class RecipeTag < ApplicationRecord
  has_many :recipe_tag_relations, dependent: :destroy
  has_many :recipes, through: :recipe_tag_relations
  

  validates :tag, presence: true, uniqueness: { case_sensitive: false }
end
