class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.string  :name, null: false
      t.integer :owner_id, null: false
      t.string  :battle_class, null: false
      t.text    :code, null: true

      t.timestamps
    end

    add_index :programs, :owner_id
  end
end
