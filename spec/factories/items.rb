FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::ChuckNorris.fact }
    unit_price { Faker::Number.number(digits: 6) }
    merchant
  end
end
