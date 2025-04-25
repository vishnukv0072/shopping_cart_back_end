class User < ApplicationRecord
  has_many :interests
  has_many :cart_items

  def get_cart_items
    cart_items = self.cart_items.includes(:product).pluck(:id, :title, :category, :image_url, :product_url, :unit_price, :quantity, :total_price, :is_bestseller)
    ids = cart_items.map(&:first)
    cart_items = cart_items.collect{|item| Hash[[:id, :title, :category, :imageUrl, :productUrl, :unitPrice, :quantity, :totalPrice, :isBestseller].zip(item)]}
    Hash[ids.zip(cart_items)]
  end
end