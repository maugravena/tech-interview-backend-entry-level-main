# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


Product.create([
  {
    name: 'Samsung Galaxy S24 Ultra',
    price: 12999.99
  },
  {
    name: 'iPhone 15 Pro Max',
    price: 14999.99
  },
  {
    name: 'Xiamo Mi 27 Pro Plus Master Ultra',
    price: 999.99
  }
])

Cart.create(
  [
    {
      total_price: 10,
      last_interaction_at: Time.current - 7.days
    },
    {
      total_price: 100,
      last_interaction_at: Time.current - 8.days
    },
    {
      total_price: 200,
      last_interaction_at: Time.current - 3.days
    },
    {
      total_price: 300,
      last_interaction_at: Time.current - 1.days
    },
    {
      total_price: 400,
      last_interaction_at: Time.current - 3.hours
    }
  ]
)
