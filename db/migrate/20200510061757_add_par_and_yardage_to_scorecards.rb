class AddParAndYardageToScorecards < ActiveRecord::Migration[6.0]
  def change
    add_column :scorecards, :par, :integer
    add_column :scorecards, :yardage, :integer
  end
end
