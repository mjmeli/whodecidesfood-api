class Decision < ApplicationRecord
  belongs_to :participant
  belongs_to :comparison

  validates :comparison_id, :participant_id, :meal, :location, presence: true

  validates_inclusion_of :meal, :in => ["Breakfast", "Lunch", "Dinner", "Snack"], :allow_nil => false
end
