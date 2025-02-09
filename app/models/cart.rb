class Cart < ApplicationRecord
  validates_numericality_of :total_price, greater_than_or_equal_to: 0

  # TODO: lógica para marcar o carrinho como abandonado e remover se abandonado
  def mark_as_abandoned
    update(abandoned: true) if last_interaction_at <= (DateTime.current - 3.hours)
  end

  def remove_if_abandoned
    destroy if last_interaction_at <= (DateTime.current - 7.days)
  end
end
