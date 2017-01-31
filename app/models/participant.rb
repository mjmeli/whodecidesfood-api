class Participant < ApplicationRecord
  belongs_to :comparison

  validates :name, :comparison_id, presence: true
  validates :score, presence: true, numericality: { greater_than_or_equal_to: 0 }

  has_many :decisions, through: :comparison
end
