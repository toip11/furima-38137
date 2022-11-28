class Item < ApplicationRecord
  belongs_to :user
  has_many :purchase_records

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :situation
  belongs_to :delivery_charge
  belongs_to :prefecture
  belongs_to :days_required
  has_one_attached :image

  validates :name, presence: true
  validates :explanation, presence: true
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }, format: { with: /\A[0-9]+\z/ }
  validates :image, presence: true

  validates :category_id, numericality: { other_than: 1 }
  validates :situation_id, numericality: { other_than: 1 }
  validates :delivery_charge_id, numericality: { other_than: 1 }
  validates :prefecture_id, numericality: { other_than: 1 }
  validates :days_required_id, numericality: { other_than: 1 }
end
