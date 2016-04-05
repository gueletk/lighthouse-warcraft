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

  it "will not attack a unit that is dead" do
    alive_unit = Unit.new(100,10)
    dead_unit = Unit.new(100,10)
    expect(dead_unit).to receive(:dead?).and_return(true)
    alive_unit.attack!(dead_unit)
    expect(dead_unit.health_points).to eql(100)
  end

  context "when attacking unit is dead" do
    it "will not do damage" do
      alive_unit = Unit.new(100,10)
      dead_unit = Unit.new(100,10)
      expect(dead_unit).to receive(:dead?).and_return(true)
      dead_unit.attack!(alive_unit)
      expect(alive_unit.health_points).to eql(100)
    end
  end

end
