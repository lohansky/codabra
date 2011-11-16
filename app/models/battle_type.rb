class BattleType < ActiveRecord::Base
  has_many :battles, foreign_key: :type, primary_key: :battle_class
  has_many :programs, foreign_key: :battle_class, primary_key: :battle_class

  validates :name, presence: true
end
