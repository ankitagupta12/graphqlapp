# Model to store item
class Item < ApplicationRecord
  belongs_to :customer

  enum status: {
    ordered: 0,
    preparing: 1,
    ready_for_collection: 2,
    delivered: 3
  }
end
