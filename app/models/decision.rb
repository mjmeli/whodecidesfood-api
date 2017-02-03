class Decision < ApplicationRecord
  belongs_to :participant
  belongs_to :comparison

  validates :comparison_id, :participant_id, :meal, :location, presence: true

  validates_inclusion_of :meal, :in => ["Breakfast", "Lunch", "Dinner", "Snack"], :allow_nil => false

  # in cases of creation, updation, and deletion, modify participant score
  after_create :increment_participant_score!
  after_update :update_participant_score!
  after_destroy :decrement_participant_score!

  def increment_participant_score!
    self.participant.increment!(:score, 1)
  end

  def update_participant_score!
    if self.participant_id_was != self.participant.id
      Participant.find(participant_id_was).decrement(:score, 1).save
      increment_participant_score!
    end
  end

  def decrement_participant_score!
    self.participant.decrement!(:score, 1)
  end
end
