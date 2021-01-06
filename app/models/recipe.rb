class Recipe < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :recipe_tag_relations, dependent: :destroy
  has_many :recipe_tags, through: :recipe_tag_relations
  
  with_options presence: true do
    validates :title
    validates :was_attached?
    validates :food
    validates :making
  end
  validates :release, inclusion: { in: [true, false]}
  validates :people, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 10, message: 'が適切な数値ではありません' }
  

  def was_attached?
    image.attached?
  end

  def save_tags(save_tags)
    current_tags = self.recipe_tags.pluck(:tag) unless self.recipe_tags.nil?
    old_tags = current_tags - save_tags
    new_tags = save_tags - current_tags
  
    # Destroy old taggings:
    old_tags.each do |old_name|
      self.recipe_tags.delete RecipeTag.find_by(tag:old_name)
    end

    # Create new taggings:
    new_tags.each do |new_name|
      post_tag = RecipeTag.find_or_create_by(tag:new_name)
      self.recipe_tags << post_tag
    end
  end
end
