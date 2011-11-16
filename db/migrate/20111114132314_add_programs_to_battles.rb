class AddProgramsToBattles < ActiveRecord::Migration
  def change
    add_column :battles, :creator_program_id, :integer, null: false
    add_column :battles, :player_program_id, :integer, null: true
    add_index  :battles, [:creator_program_id, :player_program_id]
  end
end
