class Unit < ActiveHash::Base
  self.data = [
    { id: 0, name: '--', unit: '' },
    { id: 1, name: '重さ(g)で管理', unit: 'グラム' },
    { id: 2, name: '個数で管理', unit: '個' },
    { id: 3, name: '数量管理はしない', unit: '' }
  ]

  include ActiveHash::Associations
  has_many :foods
end
