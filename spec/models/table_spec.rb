require 'rails_helper'

RSpec.describe Table, type: :model do

  describe "initialize the table" do

    it "sets up a table with a user" do
      table = Table.new(user: "Brendan")
      expect(table.user).to eq("Brendan")
    end

    it "sets up ai players" do
      table = Table.new(ai_count: 5)
      expect(table.players.length).to eq(6)
    end

    it "puts the user in the players array" do
      user_name = "Brendan"
      table = Table.new(user: user_name, ai_count: 5)
      user_found = false
      table.players_ary.each {|player| user_found = true if player.name == user_name}
      expect(user_found).to be_truthy
    end

    it "deals cards" do
      table = Table.new(ai_count: 3)
      expect(table.players_ary.length).to eq(4)
      table.players_ary.each {|player| expect(player.cards.length).to eq(2)}
    end
  end
end
