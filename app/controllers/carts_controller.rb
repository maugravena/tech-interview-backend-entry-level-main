class CartsController < ApplicationController
  before_action :load_cart, only: %w[add_items]
  ## TODO Escreva a lógica dos carrinhos aqui

  def add_items
    product = Product.find(params[:product_id])

    @cart_item = @cart.cart_items.find_or_create_by(product: product)
    @cart_item.quantity += params[:quantity]
    @cart_item.save

    render json: cart_response(@cart)
  end

  private

  def load_cart
    cart_id = session[:cart_id]

    @cart = cart_id.nil? ? create_cart : find_cart
  end

  def create_cart
    cart = Cart.create(total_price: 0)
    session[:cart_id] = cart.id
  end

  def cart_response(cart)
    {
      id: cart.id,
      products: cart.cart_items.map do |ci|
        {
          id: ci.product.id,
          name: ci.product.name,
          quantity: ci.quantity,
          unit_price: ci.product.price.round(2).to_f,
          total_price: (ci.product.price * ci.quantity).round(2).to_f
        }
      end,
      total_price: cart_total_price(cart)
    }
  end

  def cart_total_price(cart)
    items_total_price = cart.cart_items.map { |ci| ci.product.price * ci.quantity }

    items_total_price.sum.to_f
  end

  def find_cart = Cart.find(session[:cart_id])
end
