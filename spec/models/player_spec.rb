require 'rails_helper'

RSpec.describe Player, type: :model do

  describe "initialize player" do
    it "defaults to 200 dollars" do
      bob = Player.new
      expect(bob.money).to eq(200)
    end

    it "can set start money" do
      bob = Player.new(:money => 300)
      expect(bob.money).to eq(300)
    end

    it "can set name" do
      bob = Player.new(:name => 'bob')
      expect(bob.name).to eq('bob')
    end
  end

  describe "exchanging money" do
    it "can bet money" do
      bob = Player.new
      bob.bet(50)
      expect(bob.money).to eq(150)
    end

    it "can bet all money" do
      bob = Player.new
      bob.bet(200)
      expect(bob.money).to eq(0)
    end

    it "can go all in" do
      bob = Player.new
      bet = bob.all_in
      expect(bob.money).to eq(0)
      expect(bet).to eq(200)
    end

    it "can recieve money" do
      bob = Player.new
      bob.win(50)
      expect(bob.money).to eq(250)
    end

    it "can't bet more than total money" do
      bob = Player.new
      expect(bob.money).to eq(200)
    end

    it "shows player as active when they have money" do
      bob = Player.new
      expect(bob.active?).to be_truthy
    end

    it "shows player as not active when they have no money" do
      bob = Player.new
      bob.all_in
      expect(bob.active?).not_to be_truthy
    end
  end
end
