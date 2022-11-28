FactoryBot.define do
  factory :purchase_record_shipping_to do
    postal_code                 { "123-4567" }
    prefecture_id               { 3 }
    municipality                { "あああ" }
    address                     { "123" }
    building_name               { "" }
    phone_number                { 1234567890 }
    token                       { "tok_abcdefghijk00000000000000000" }
    association :user
    association :item
  end
end