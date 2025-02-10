require 'rails_helper'

RSpec.describe MarkCartAsAbandonedJob, type: :job do
  include ActiveJob::TestHelper

  subject(:job) { described_class.new }

  describe '#perform' do
    it 'calls the service' do
      expect(AbandonedCartsMarker).to receive(:new).and_call_original

      expect_any_instance_of(AbandonedCartsMarker).to receive(:call)

      job.perform
    end
  end
end
