class AddRoundsToBattles < ActiveRecord::Migration
  def change
    add_column :battles, :rounds, :integer, null: true
  end
end
