class RemoveTokensFromCodabras < ActiveRecord::Migration
  def up
    remove_column :codabras, :perishable_token
  end

  def down
    add_column :codabras, :perishable_token, :string
  end
end
