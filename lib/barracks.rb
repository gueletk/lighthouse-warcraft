class Barracks

  attr_reader :gold, :food

  def initialize
    @gold = 1000
    @food = 80
  end

  def train_footman
    if can_train_footman?
      charge_price(135)
      charge_food(2)
      Footman.new
    end
  end

  def train_peasant
    if can_train_peasant?
      charge_price(90)
      charge_food(5)
      Peasant.new
    end
  end

  def can_train_peasant?
    gold >= 90 && food >= 5
  end

  def charge_price(price)
    @gold -= price
  end

  def charge_food(food_cost)
    @food -= food_cost
  end

  def can_train_footman?
    gold >= 135 && food >= 2
  end

end
