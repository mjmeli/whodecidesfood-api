class AddDefaultScoreToParticipants < ActiveRecord::Migration[5.0]
  def change
    change_column :participants, :score, :integer, default: 0
  end
end
