require 'rails_helper'

RSpec.describe '/carts', type: :request do
  describe 'GET /cart' do
    let(:cart) { create(:cart, :with_items) }

    it 'renders a successful response' do
      cart
      get carts_url

      response_body = JSON.parse(response.body).deep_symbolize_keys
      products = response_body[:products]

      expect(response).to have_http_status(:ok)
      expect(products.first[:name]).to eq('Test Product')
      expect(products.first[:quantity]).to eq(1)
      expect(products.first[:unit_price]).to eq(10.11)
      expect(products.last[:name]).to eq('Test Product')
      expect(products.last[:quantity]).to eq(1)
      expect(products.first[:unit_price]).to eq(10.11)
      expect(response_body[:total_price]).to eq(20.22)
    end
  end

  describe 'POST /add_items' do
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

    context 'when has differents kinds of products' do
      subject do
        post '/cart/add_items', params: { product_id: product.id, quantity: 1 }, as: :json
        post '/cart/add_items', params: { product_id: tshirt.id, quantity: 1 }, as: :json
      end

      let(:tshirt) { create(:product, name: 'T-shirt', price: 50) }

      it 'returns the sum of all cart items -> cart total_price' do
        allow_any_instance_of(CartsController).to receive(:session) { { cart_id: cart.id } }

        subject
        body = JSON.parse(response.body).deep_symbolize_keys

        expect(body[:total_price]).to eq(70.22)
      end
    end

    it 'returns attributes in the json body' do
      allow_any_instance_of(CartsController).to receive(:session) { { cart_id: cart.id } }

      post '/cart/add_items', params: { product_id: product.id, quantity: 2 }, as: :json

      expected_response = {
        id: cart.id,
        products: [
          {
            id: product.id,
            name: product.name,
            quantity: 3,
            unit_price: product.price.round(2).to_f,
            total_price: (product.price * 3).round(2).to_f
          }
        ],
        total_price: 30.33
      }

      expect(JSON.parse(response.body).deep_symbolize_keys).to eq(expected_response)
    end
  end

  describe 'DELETE /cart/:product_id' do
    let(:cart) { create(:cart, :with_items) }

    it 'destroys the requested cart product' do
      expect do
        delete "/cart/#{cart.products.last.id}"
      end.to change(cart.products, :count).by(-1)
    end

    context "when 'can\'t find the product in cart" do
      it 'destroys the requested cart product' do
        cart

        delete '/cart/abc123'

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq({ 'error' => 'Product not found' })
      end
    end
  end
end
