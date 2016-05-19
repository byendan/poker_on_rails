require 'rails_helper'

RSpec.describe Deck, type: :model do

  describe "deck is a standard deck with unique cards" do
    let(:deck) {Deck.new}
    it "has 52 cards" do
      expect(deck.size).to eq(52)
    end

    it "has all unique cards" do
      card_count = Hash.new(0)
      deck.cards.each {|card| card_count[card] += 1}
      card_counts_equal_one = true
      card_count.each do |card, count|
        card_counts_equal_one = false if card_count[card] > 1
      end
      expect(card_counts_equal_one).to be_truthy
    end
  end

  describe "deck functions correctly for drawing, and shuffling" do
    let(:deck) {Deck.new}

    # Drawing a card will make sure a card is removed from the
    # deck, and that you get back the first card in the deck
    it "can draw a card" do
      beginning_deck_length = deck.size
      expected_card = deck.cards.sort.first
      card = deck.draw
      expect(deck.size).to eq(beginning_deck_length - 1)
      expect(card).to eq(expected_card)
    end

    it "can shuffle the deck" do
      deck_pre_order = deck.cards.sort
      deck.shuffle
      deck_post_order = deck.cards.sort 
      expect(deck.size).to eq(52)
      expect(deck_pre_order).not_to eq(deck_post_order)
    end

    it "removes all cards from deck when pulling cards" do
      d = Deck.new
      d.pull_cards
      expect(d.size).to eq(0)
    end

    it "reorders the cards in the deck with order swap" do
      d = Deck.new
      pre_order_deck = d.pull_cards
      post_order_deck = d.order_swap(pre_order_deck)
      expect(pre_order_deck).not_to eq(post_order_deck)
    end


  end
end
