
require 'rails_helper'

RSpec.describe CartItem, type: :model do
  describe 'associations' do
    it 'belongs to a cart' do
      association = described_class.reflect_on_association(:cart)
      expect(association).to be_a(ActiveRecord::Reflection::AssociationReflection)
      expect(association.macro).to eq :belongs_to
    end

    it 'belongs to a product' do
      association = described_class.reflect_on_association(:product)
      expect(association).to be_a(ActiveRecord::Reflection::AssociationReflection)
      expect(association.macro).to eq :belongs_to
    end
  end

  context 'when creating a valid cart_item' do
    let(:cart) { create(:cart) }
    let(:product) { create(:product) }
    let(:cart_item) { build(:cart_item, cart: cart, product: product) }

    it 'is valid with valid attributes' do
      expect(cart_item).to be_valid
    end

    it 'saves successfully' do
      expect { cart_item.save }.to change(CartItem, :count).by(1)
    end

    it 'is associated with a cart' do
      cart_item.save
      expect(cart_item.cart).to eq(cart)
    end

    it 'is associated with a product' do
      cart_item.save
      expect(cart_item.product).to eq(product)
    end
  end

  context 'when creating an invalid cart_item' do
    it 'is invalid without a cart' do
      cart_item = build(:cart_item, cart: nil, product: create(:product))
      expect(cart_item).to_not be_valid
    end

    it 'is invalid without a product' do
      cart_item = build(:cart_item, cart: create(:cart), product: nil)
      expect(cart_item).to_not be_valid
    end
  end
end
