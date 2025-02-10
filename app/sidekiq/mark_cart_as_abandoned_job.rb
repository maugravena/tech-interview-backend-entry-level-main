class MarkCartAsAbandonedJob
  include Sidekiq::Job

  def perform
    AbandonedCartsMarker.new.call
  end
end
