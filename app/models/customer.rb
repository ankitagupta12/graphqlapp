# Model to store article
class Customer < ApplicationRecord
  belongs_to :table
  has_many :items
end
