class MarkCartAsAbandonedJob
  include Sidekiq::Job

  def perform
    AbandonedCartsMarker.new.call
    AbandonedCartsRemover.new.call
  end
end
