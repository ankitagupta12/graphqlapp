# Model to store table
class Table < ApplicationRecord
  has_many :customers
end
