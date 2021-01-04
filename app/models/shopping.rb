class Shopping < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, uniqueness: { scope: :user_id, case_sensitive: false }
  validates :category_id, numericality: { other_than: 0, message: "を入力してください" }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
end
