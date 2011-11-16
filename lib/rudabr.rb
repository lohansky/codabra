#!/usr/bin/ruby

class CodabrPrivate
  attr_reader :hp
  attr_reader :level
  attr_reader :points

  def hp=(v)
    @hp = v
  end
 
  def initialize
    @hp = 4
    @level = 1
  end
end

class Codabr

  attr_reader :block
  attr_reader :attack_to

  def initialize
    @private = CodabrPrivate.new
    @name = "Codabr"
    @block = "nothing"
    @attack_to = "nothing"
  end

  def hp
    @private.hp
  end

  def level
    @private.level
  end
  
  def prepare
    nil
  end

  def attack(enemy)
    nil
  end

  class << self

    def battle(c1, c2)
      round = 1
      while c1.hp > 0 and c2.hp > 0
        puts "Round #{round}"

        c1.prepare
        puts "#{c1.name} blocked #{c1.block}"
        c2.prepare
        puts "#{c2.name} blocked #{c2.block}"

        c1.attack(c2)
        puts "#{c1.name} attacked #{c2.name} to #{c1.attack_to}"
        c2.attack(c1)
        puts "#{c2.name} attacked #{c1.name} to #{c2.attack_to}"

        c2.defend(c1)
        c1.defend(c2)

        puts "#{c1.name} HP is #{c1.hp}"
        puts "#{c2.name} HP is #{c2.hp}"

        round += 1

        sleep 1 if c1.hp > 0 and c2.hp > 0
      end

      if c1.hp > 0
        puts "#{c1.name} win!"
      elsif c2.hp > 0
        puts "#{c2.name} win!"
      else
        puts "#{c1.name} and #{c2.name} both are dead!"
      end
    end

  end
  
  def defend(enemy)
    return if self.block == enemy.attack_to
    @private.hp -= enemy.level
  end

  private :instance_variables

end

class Myself < Codabr

  def initialize
    super
    @bs = [:body, :head, :legs]
  end

  def name
    :Rudolf
  end

  def prepare
    @block = @bs[rand(3)]
  end

  def attack(enemy)
    @attack_to = @bs[rand(3)]
  end
end

class Enemy < Codabr

  def initialize
    super
    @bs = [:body, :head, :legs]
  end

  def name
    :Greg
  end

  def prepare
    @block = @bs[rand(3)]
  end

  def attack(enemy)
    @attack_to = :head
  end
end

me = Myself.new
enemy = Enemy.new

puts me.instance_variable_get(:@name)

Codabr.battle(me, enemy)

