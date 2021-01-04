class Category < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: '穀類' },
    { id: 2, name: 'いも・でんぷん' },
    { id: 3, name: '果物' },
    { id: 4, name: '野菜' },
    { id: 5, name: '魚介類' },
    { id: 6, name: '肉類' },
    { id: 7, name: '卵類' },
    { id: 8, name: '乳製品' },
    { id: 9, name: '調味料' },
    { id: 10, name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :stocks
  has_many :shoppings
end
