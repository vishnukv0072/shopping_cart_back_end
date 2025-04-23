class User < ApplicationRecord
  has_many :interests
  has_many :cart_items
end