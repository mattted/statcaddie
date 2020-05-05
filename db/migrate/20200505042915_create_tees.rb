class CreateTees < ActiveRecord::Migration[6.0]
  def change
    create_table :tees do |t|
      t.string :color
      t.belongs_to :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
