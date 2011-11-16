# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

cariba_code_template = <<EOF
puts "head"
EOF

battle_cariba = BattleType.create(battle_class: 'Battle::Cariba', name: 'Cariba', code_template: cariba_code_template)

splinter = Codabra.create(
  name: 'splinter',
  active: false,
  locale: 'en',
  level: 1,
  email: 'splinter@codabra.com',
  password: 'splinter',
  password_confirmation: 'splinter'
)

splinter_cariba_code = <<EOF
if ARGV[0] == 'attacks'
  puts ["body", "legs"].shuffle.first
end
EOF

splinter.programs.create!(
  name: "Splinter's Cariba Program",
  battle_class: battle_cariba.battle_class,
  code: splinter_cariba_code
)
