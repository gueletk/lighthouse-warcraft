require_relative 'spec_helper'

describe SeigeEngine do

  context "#new" do

    seige_engine = SeigeEngine.new

    it "is a SeigeEngine" do
      expect(seige_engine.is_a?(SeigeEngine)).to eq(true)
    end

    it "has 400 HP" do
      expect(seige_engine.health_points).to eq(400)
    end

    it "has 50 AP" do
      expect(seige_engine.attack_power).to eq(50)
    end

  end

  context "#attack!" do

    seige_engine = SeigeEngine.new

    it "does double damage against Barracks" do
      barracks = Barracks.new
      seige_engine.attack!(barracks)
      expect(barracks.health_points).to eq(500 - seige_engine.attack_power * 2)
    end

    it "does normal (50) damage against other SeigeEngines" do
      other_seige_engine = SeigeEngine.new
      seige_engine.attack!(other_seige_engine)
      expect(other_seige_engine.health_points).to eq(SeigeEngine::STARTING_HEALTH - SeigeEngine::ATTACK_POWER)
    end

    it "does no damage against non-SeigeEngine units (such as footmen and peasants)" do
      footman = Footman.new
      seige_engine.attack!(footman)
      expect(footman.health_points).to eq(60)
    end

  end

end

describe Barracks do

  it "has 500HP and knows its health_points" do
    barracks = Barracks.new
    expect(barracks.health_points).to eq(500)
  end

  context "when Barracks is created" do
    it "has 500 lumber" do
      barracks = Barracks.new
      expect(barracks.lumber).to eq(500)
    end
  end

  context "#create_seige_engine" do

    barracks = Barracks.new

    it "returns nil if there are not enough resources to create a SeigeEngine" do
      expect(barracks).to receive(:gold).and_return(0)
      expect(barracks.create_seige_engine).to eq(nil)
    end

    it "returns a SeigeEngine" do
      barracks = Barracks.new
      expect(barracks.create_seige_engine.class).to eq(SeigeEngine)
    end

    barracks.create_seige_engine

    it "costs 200 gold" do
      expect(barracks.gold).to eq(800)
    end

    it "costs 60 lumber" do
      expect(barracks.lumber).to eq(440)
    end

    it "costs 3 food" do
      expect(barracks.food).to eq(77)
    end

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
