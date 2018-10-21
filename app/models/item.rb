# Model to store item
class Item < ApplicationRecord
  belongs_to :customer
end
