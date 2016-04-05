class Unit

  attr_reader :health_points, :attack_power

  def initialize(health_points, attack_power)
    @health_points = health_points
    @attack_power = attack_power
  end

  def attack!(enemy)
    case enemy.class
    when Barracks
      enemy.damage(attack_power)
    else
      enemy.damage(attack_power) if !enemy.dead? && !self.dead?
    end
  end

  def damage(enemy_attack_power)
    @health_points -= enemy_attack_power
  end

  def dead?
    health_points <= 0
  end

end
