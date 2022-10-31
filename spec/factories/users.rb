FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { Faker::Lorem.characters(min_alpha: 3, min_numeric: 3, number: 8)}
    password_confirmation { password }
    last_name             { '苗字' }
    first_name            { '名前' }
    last_name_reading     { 'ミョウジ' }
    first_name_reading    { 'ナマエ' }
    birthday              { '2022-10-31' }
  end
end
