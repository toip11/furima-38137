class PurchaseRecordShippingTo
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :municipality, :address, :building_name, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :municipality
    validates :address
    validates :phone_number, length: { only_integer: true, minimum: 10, maximum: 11 }, format: { with: /\A[0-9]+\z/ }
    validates :token
  end
    validates :prefecture_id, numericality: { other_than: 1 }

  def save
    purchase = PurchaseRecord.create(user_id: user_id, item_id: item_id)
    ShippingTo.create(postal_code: postal_code, prefecture_id: prefecture_id, municipality: municipality, address: address, building_name: building_name, phone_number: phone_number, purchase_record_id: purchase.id)
  end
end