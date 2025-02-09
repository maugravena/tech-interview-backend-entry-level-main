require 'rails_helper'

RSpec.describe "/carts", type: :request do
  pending "TODO: Escreva os testes de comportamento do controller de carrinho necessários para cobrir a sua implmentação #{__FILE__}"

  describe "POST /add_items" do
    let(:cart) { create(:cart) }
    let(:product) { create(:product) }
    let!(:cart_item) { create(:cart_item, cart: cart, product: product, quantity: 1) }

    context 'when the product already is in the cart' do
      subject do
        post '/cart/add_items', params: { product_id: product.id, quantity: 1 }, as: :json
        post '/cart/add_items', params: { product_id: product.id, quantity: 1 }, as: :json
      end

      it 'updates the quantity of the existing item in the cart' do
        allow_any_instance_of(CartsController).to receive(:session) { { cart_id: cart.id } }

        expect { subject }.to change { cart_item.reload.quantity }.by(2)
      end
    end
  end
end
