class CreateCodabras < ActiveRecord::Migration
  def change
    create_table :codabras do |t|
      t.string  :name, null: false, uniqueness: true
      t.string  :email, null: false, uniqueness: true
      t.integer :level, null: false, default: 1
      t.boolean :active, null: false, default: false
      t.string  :locale, length: 2, null: false, default: 'en'
      t.string  :crypted_password, null: false
      t.string  :password_salt, null: false
      t.string  :persistence_token, null: false
      t.string  :perishable_token, null: true

      t.timestamps
    end

    add_index :codabras, :name, unique: true
    add_index :codabras, :email, unique: true
  end
end
