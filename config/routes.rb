require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  resources :products
  resources :carts, only: %w[index]

  post '/cart/add_items', to: 'carts#add_items'
  delete '/cart/:product_id', to: 'carts#remove_product'

  get "up" => "rails/health#show", as: :rails_health_check

  root "rails/health#show"
end
