class CreateDecisions < ActiveRecord::Migration[5.0]
  def change
    create_table :decisions do |t|
      t.references :participant, foreign_key: true, index: true
      t.references :comparison, foreign_key: true, index: true
      t.string :location, default: ""
      t.string :meal, default: ""

      t.timestamps
    end
  end
end
