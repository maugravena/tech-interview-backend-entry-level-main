class CartsController < ApplicationController
  before_action :load_cart, only: %w[add_items]
  ## TODO Escreva a lógica dos carrinhos aqui

  def add_items
    product = Product.find(params[:product_id])

    @cart_item = @cart.cart_item.find_or_create_by(product: product)
    @cart_item.quantity += params[:quantity]
    @cart_item.save
  end

  private

  def load_cart
    cart_id = session[:cart_id]

    @cart = cart_id.nil? ? Cart.create(total_price: 0) : Cart.find(session[:cart_id])
  end
end
