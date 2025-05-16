class CartItem < ApplicationRecord
  # before_save :set_total_price
  before_save proc { |obj| obj.total_price = unit_price * quantity }
  belongs_to :user
  belongs_to :product, foreign_key: :id

  def set_total_price
    self.total_price = unit_price * quantity
  end
end