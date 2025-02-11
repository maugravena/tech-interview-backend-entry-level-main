class Cart < ApplicationRecord
  has_many :cart_items
  has_many :products, through: :cart_items

  validates_numericality_of :total_price, greater_than_or_equal_to: 0

  def mark_as_abandoned
    update(abandoned: true) if last_interaction_at <= (DateTime.current - 3.hours)
  end

  def remove_if_abandoned
    destroy if last_interaction_at <= (DateTime.current - 7.days)
  end
end
