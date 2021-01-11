class Plan < ApplicationRecord
  validates :people, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 10, message: 'が適切な数値ではありません' }
  validates :date, presence: true

  belongs_to :recipe
  belongs_to :user
end
