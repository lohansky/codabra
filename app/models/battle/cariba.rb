module CaribaPlayer
  attr_accessor :hp, :block, :attack, :last_attacked, :extra_damage, :program

  def dead?
    self.hp <= 0
  end
end

class Battle::Cariba < Battle

  BODYPARTS = ['head', 'body', 'legs'].freeze

  def do_run
    @players = [self.creator.extend(CaribaPlayer), self.player.extend(CaribaPlayer)]
    @players[0].program = self.creator_program
    @players[1].program = self.player_program
    @players.shuffle!

    self.rounds = 1

    clear_log

    set_start_hp

    while both_are_alive?
      write_log("round \##{self.rounds}")
      do_round
      self.rounds += 1
      save
    end

    if @players[1].dead?
      self.winner = @players[0]
      self.winner_program = @players[0].program
    else
      self.winner = @players[1]
      self.winner_program = @players[1].program
    end

    write_log("#{self.winner.name} win!")

    true
  end

protected

  def both_are_alive?
    not @players[0].dead? and not @players[1].dead?
  end

  def set_start_hp
    @players.each do |p|
      p.hp = p.level * 10
      p.extra_damage = 0
      write_log("#{p.name}'s hp is #{p.hp}")
    end
  end

  def do_round
    do_action('blocks from?')
    do_action('attacks to?')
    do_attack(@players[0], @players[1])
    do_attack(@players[1], @players[0]) unless @players[1].dead?
    do_action('was attacked to')
  end

  def do_action(action)
    @players.each do |p|

      if action == 'was attacked to'
        action += " #{p.last_attacked}"
      end

      rc, output = p.program.execute(action)
      output.chomp!

      if rc.success?
        if BODYPARTS.include?(output)
          case action
          when 'blocks from?'
            p.block = output
            write_log("#{p.name} sets block to #{output}")
          when 'attacks to?'
            p.attack = output
            write_log("#{p.name} tries attack to #{output}")
          end
        else
          write_log("#{p.name} is dulling") unless action.include?('was attacked to')
        end
      else
        write_log("#{p.name} crashs")
      end
    end
  end

  def do_attack(me, enemy)
    return unless BODYPARTS.include?(me.attack)

    if enemy.block == me.attack
      write_log("#{enemy.name} blocks from #{me.name}")
      enemy.last_attacked = nil
      enemy.extra_damage = 0
    else
      enemy.hp -= 1
      if enemy.last_attacked == me.attack
        enemy.extra_damage += 1
        enemy.hp -= enemy.extra_damage
        write_log("#{me.name} bits #{enemy.name} with #{enemy.extra_damage + 1} damage")
      else
        write_log("#{me.name} bits #{enemy.name} with 1 damage")
      end
      enemy.last_attacked = me.attack
      write_log("#{enemy.name} hp decreases to #{enemy.hp}")
    end
  end

end