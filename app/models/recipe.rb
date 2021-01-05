class Recipe < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :recipe_tags, through: recipe_tag_relations
  has_many :recipe_tag_relations, dependent: :destroy
  
  validates :title, presence: true
  validates :people, presence: true
  validates :food, presence: true
  validates :making, presence: true
  validates :release, inclusion: { in: [true, false]}
end
