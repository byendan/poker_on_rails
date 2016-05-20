require 'rails_helper'

RSpec.describe Dealer, type: :model do
  describe "dealer initializes with 6 decks, and shuffles them" do

    it "puts all decks into a master deck" do
      dealer = Dealer.new
      expect(dealer.master_deck.length).to eq(52 * 6)
    end

    it "shuffles decks together into a master deck" do
      dealer = Dealer.new
      pre_shuffle_decks = dealer.master_deck.sort
      dealer.shuffle_decks
      post_shuffle_decks = dealer.master_deck.sort
      expect(pre_shuffle_decks).not_to eq(post_shuffle_decks)
    end
  end

  describe "dealer can pass out cards" do
    it "can pass out a card" do
      dealer = Dealer.new
      card_count = dealer.master_deck.length
      card = dealer.pass_card
      expect(dealer.master_deck.length).to eq(card_count - 1)
      expect(card).to be_valid
    end

    it "can pass out two cards per player(1 player)" do
      dealer = Dealer.new
      players = ['bob']
      card_count = dealer.master_deck.length
      correct_hand = {'bob' => [dealer.master_deck[card_count - 1], dealer.master_deck[card_count - 2]]}
      result_hand = dealer.distribute(players)
      expect(dealer.master_deck.length).to eq(card_count - 2)
      expect(result_hand).to eq(correct_hand)
    end

    it "can pass out two cards per player(2 players)" do
      dealer = Dealer.new
      players = %w(bob sam)
      card_count = dealer.master_deck.length
      correct_hand = {'bob' => [dealer.master_deck[card_count - 1], dealer.master_deck[card_count - 3]],
                      'sam' => [dealer.master_deck[card_count - 2], dealer.master_deck[card_count - 4]]}
      result_hand = dealer.distribute(players)
      expect(dealer.master_deck.length).to eq(card_count - 4)
      expect(result_hand).to eq(correct_hand)
    end
  end
end
