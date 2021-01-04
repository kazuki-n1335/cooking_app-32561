class Stock < ApplicationRecord
  belongs_to :user
  validates :category_id, numericality: { other_than: 0 }
  validates :name, uniqueness: { scope: :user_id }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
end
