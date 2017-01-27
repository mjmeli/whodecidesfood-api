class CreateComparisons < ActiveRecord::Migration[5.0]
  def change
    create_table :comparisons do |t|
      t.string :title, default: ""
      t.integer :owner_id

      t.timestamps
    end
    add_index :comparisons, :owner_id
  end
end
