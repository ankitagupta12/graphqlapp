# Model to store article
class Article < ApplicationRecord
  has_many :comments
end
