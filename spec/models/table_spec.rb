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

  describe "table game functions" do
    let(:table) {Table.new(ai_count: 3)}
    it "deals a flop to the table" do
      table.flop
      expect(table.community_cards.length).to eq(3)
    end

    it "deals a single card to the table" do
      table.flip
      expect(table.community_cards.length).to eq(1)
      table.flip
      expect(table.community_cards.length).to eq(2)
    end

    it "deals all cards to the table, then dealing is complete" do
      t = Table.new(ai_count: 1)
      table.flop
      table.flip
      table.flip
      expect(table.community_cards.length).to eq(5)
      expect(table.dealing_finished).to be true
    end

    it "clears the community cards on demand" do
      t = Table.new(ai_count: 1)
      table.flop
      2.times {table.flip}
      expect(table.dealing_finished).to be true
      table.clear_community_cards
      expect(table.dealing_finished).to be false
    end

    it "clears the players cards" do
      t = Table.new(ai_count: 2)
      t.clear_player_cards
      t.players_ary.each {|player| expect(player.cards.length).to eq(0)}
      expect(t.dealer.master_deck.length).to eq(52 * 6)
    end

    it "clears all cards on the table" do
      t = Table.new(ai_count: 2)
      t.flop
      2.times {t.flip}
      t.clear_all_cards
      t.players_ary.each {|player| expect(player.cards.length).to eq(0)}
      expect(t.dealer.master_deck.length).to eq(52 * 6)
    end
  end

end
