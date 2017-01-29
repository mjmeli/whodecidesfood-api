class Comparison < ApplicationRecord
  validates :title, :owner_id, presence: true

  belongs_to :owner, :class_name => 'User'

  has_many :participants, dependent: :destroy

  scope :recent, -> {
    order(:updated_at)
  }
end
