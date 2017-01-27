class CreateComparisons < ActiveRecord::Migration[5.0]
  def change
    create_table :comparisons do |t|
      t.string :title, default: ""
      t.integer :owner

      t.timestamps
    end
    add_index :comparisons, :owner
  end
end
