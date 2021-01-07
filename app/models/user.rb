class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,}+\z/i, message: 'は英数混合かつ6文字以上で入力してください' }
  validates :nickname, presence: true

  has_many :stocks
  has_many :shoppings
  has_many :recipes
  has_many :comments
end
