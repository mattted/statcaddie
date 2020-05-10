class AddLookupIdToHoleAndScorecard < ActiveRecord::Migration[6.0]
  def change
    add_column :holes, :lid, :string
    add_column :scorecards, :lid, :string
    add_index :holes, :lid
    add_index :scorecards, :lid
  end
end
