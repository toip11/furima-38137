class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :password, format: { with:  /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze }
  validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一\p{Han}]+\z/ }
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一\p{Han}]+\z/ }
  validates :last_name_reading, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/ }
  validates :first_name_reading, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/ }
  validates :birthday, presence: true
end
