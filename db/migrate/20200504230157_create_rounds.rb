class CreateRounds < ActiveRecord::Migration[6.0]
  def change
    create_table :rounds do |t|
      t.datetime :date
      t.string :tee
      t.belongs_to :course, null: false, foreign_key: true
      t.belongs_to :golfer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
