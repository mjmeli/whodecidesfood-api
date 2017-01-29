class CreateParticipants < ActiveRecord::Migration[5.0]
  def change
    create_table :participants do |t|
      t.references :comparison, foreign_key: true, index:true
      t.string :name
      t.integer :score

      t.timestamps
    end
  end
end
