class Shopping < ApplicationRecord
  belongs_to :user
  validates :name, uniqueness: { scope: :user_id }
  validates :category_id, numericality: { other_than: 0 }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
end
