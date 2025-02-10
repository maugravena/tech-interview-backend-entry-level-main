class AbandonedCartsMarker
  def initialize; end

  def call
    Cart.find_each(&:mark_as_abandoned)
  end
end
