require_relative 'spec_helper'

describe Barracks do

  it "has 500HP and knows its health_points" do
    barracks = Barracks.new
    expect(barracks.health_points).to eq(500)
  end

end

describe Footman do

  it "attacks a barracks with half its hit points" do
    footman = Footman.new
    enemy = Barracks.new
    footman.attack!(enemy)
    expect(enemy.health_points).to eq(500 - (footman.attack_power / 2).ceil)
  end

end

describe Unit do

  it "is not dead when created" do
    unit = Unit.new(100, 10)
    expect(unit.dead?).to eq(false)
  end

end
