class SeigeEngine < Unit

  STARTING_HEALTH = 400
  ATTACK_POWER = 50

  def initialize
    super(STARTING_HEALTH, ATTACK_POWER)
  end

  def attack!(enemy)
    if enemy.is_a?(Barracks)
      enemy.damage(attack_power * 2)
    elsif enemy.is_a?(SeigeEngine)
      super(enemy)
    end
  end

end
