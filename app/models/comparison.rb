class Comparison < ApplicationRecord
  validates :title, :owner, presence: true
end
