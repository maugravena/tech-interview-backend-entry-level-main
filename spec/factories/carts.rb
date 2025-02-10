FactoryBot.define do
  factory :cart, aliases: [:shopping_cart] do
    total_price { 100 }
  end

  trait :with_items do
    after(:create) { |cart| create_list(:cart_item, 2, cart: cart) }
  end

  trait :abandoned do
    last_interaction_at { Time.current - 3.hours }
  end

  trait :abandoned_seven_days do
    last_interaction_at { Time.current - 7.days }
  end
end
