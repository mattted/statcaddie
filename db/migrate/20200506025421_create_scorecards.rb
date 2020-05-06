class CreateScorecards < ActiveRecord::Migration[6.0]
  def change
    create_table :scorecards do |t|
      t.boolean :fairway
      t.boolean :gir
      t.integer :hole_number
      t.text :notes
      t.integer :putts
      t.integer :strokes
      t.belongs_to :round, null: false, foreign_key: true

      t.timestamps
    end
  end
end
