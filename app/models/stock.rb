class Stock < ApplicationRecord
  
  belongs_to :food
  belongs_to :user
  validates :num, numericality: {greater_than_or_equal_to: 0}

end
