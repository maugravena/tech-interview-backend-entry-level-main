FactoryBot.define do
  factory :cart, aliases: [:shopping_cart] do
    total_price { 100 }
  end

  trait :with_items do
    after(:create) { |cart| create_list(:cart_item, 2, cart: cart) }
  end
end
