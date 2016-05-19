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
end
