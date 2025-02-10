require 'rails_helper'

RSpec.describe AbandonedCartsRemover, type: :service do
  subject(:service) { described_class.new }

  let(:abandoned_carts) { create_list(:cart, 2, :abandoned_seven_days) }

  describe '#call' do
    it 'removes all carts abandoned for more than seven days' do
      abandoned_carts

      expect { service.call }.to change { Cart.count }.by(-2)
    end
  end
end
