class Recipe < ApplicationRecord
  has_one_attached :image
  belongs_to :user

  validates :title, presence: true
  validates :people, presence: true
  validates :food, presence: true
  validates :making, presence: true
  validates :release, inclusion: { in: [true, false]}
end
