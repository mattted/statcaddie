class CreateHoles < ActiveRecord::Migration[6.0]
  def change
    create_table :holes do |t|
      t.integer :hole_number
      t.integer :par
      t.integer :yardage
      t.belongs_to :tee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
