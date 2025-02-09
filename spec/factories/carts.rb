FactoryBot.define do
  factory :cart, aliases: [:shopping_cart] do
    total_price { 100 }
  end
end
