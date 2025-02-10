class AbandonedCartsRemover
  def initialize; end

  def call
    Cart.find_each(&:remove_if_abandoned)
  end
end
