class Food < ApplicationRecord
  # アクティブハッシュモデルのアソシエーション
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :unit
  belongs_to :food_tag

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :food_tag_id, :unit_id, numericality: { other_than: 0, message: 'を入力してください' }
  validates :time, allow_blank: true, numericality: { only_integer: true }
end
