class Interest < ApplicationRecord
  belongs_to :user, optional: true
end