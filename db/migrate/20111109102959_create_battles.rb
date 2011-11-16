class CreateBattles < ActiveRecord::Migration
  def change
    create_table :battles do |t|
      t.string  :type, null: false
      t.integer :creator_id, null: false
      t.integer :player_id, null: true
      t.string  :status, null: false, default: 'new'
      t.integer :winner_id, null: true

      t.timestamps
    end

    add_index :battles, [:creator_id, :player_id]
    add_index :battles, :status
    add_index :battles, :winner_id
  end
end
