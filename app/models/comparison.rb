class Comparison < ApplicationRecord
  validates :title, :owner_id, presence: true

  belongs_to :owner, :class_name => 'User'
end