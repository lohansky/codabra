class AddWinnerProgramIdToBattles < ActiveRecord::Migration
  def change
    add_column :battles, :winner_program_id, :integer, null: true
    add_index  :battles, :winner_program_id
  end
end
