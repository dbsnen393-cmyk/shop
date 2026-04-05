class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_many :products, through: :line_items

  def total_price
    line_items.sum { |item| item.total_price }
  end

  def total_items
    line_items.sum(:quantity)
  end
end
