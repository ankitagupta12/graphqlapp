# Model to store article
class Comment < ApplicationRecord
  belongs_to :article
end
