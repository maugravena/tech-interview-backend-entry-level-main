require 'rails_helper'

RSpec.describe AbandonedCartsMarker, type: :service do
  subject(:service) { described_class.new }

  let(:abandoned_carts) { create_list(:cart, 2, :abandoned) }

  describe '#call' do
    it 'marks as abandoned when there is no interaction for more than three hours' do
      abandoned_carts

      carts = Cart.all

      service.call

      expect(carts.first.abandoned?).to be true
      expect(carts.last.abandoned?).to be true
    end
  end
end
