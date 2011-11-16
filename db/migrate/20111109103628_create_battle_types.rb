class CreateBattleTypes < ActiveRecord::Migration
  def change
    create_table :battle_types do |t|
      t.string  :name, null: false
      t.string  :battle_class, null: false, uniqueness: true
      t.text    :code_template, null: true

      t.timestamps
    end
  end
end
