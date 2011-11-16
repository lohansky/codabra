class AddPublicToBattle < ActiveRecord::Migration
  def change
    add_column :battles, :public, :boolean, null: false, default: true
  end
end
