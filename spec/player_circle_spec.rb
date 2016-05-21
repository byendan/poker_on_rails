require 'rails_helper'
require 'player_circle'


RSpec.describe PlayerCircle do
  describe "player circle doubley linked list" do
    let(:players) {[Player.new(name:'bob'), Player.new(name:'jan'), Player.new(name:'jake')]}
    it "can create nodes and ensure the first one has the right name" do
      list = PlayerCircle.create(players)
      expect(list.name).to eq('bob')
    end

    it "can itteraterate over nodes, and they will have same contents as original players" do
      list = PlayerCircle.create(players)
      list_players = []
      cur = list
      begin
        list_players << cur.player
        cur = cur.next
      end until cur.is_dealer
      expect(list_players).to eq(players)
    end

    it "can shift the dealer" do
      list = PlayerCircle.create(players)
      post_shift_dealer = list.next
      list = PlayerCircle.shift(list)
      expect(post_shift_dealer).to eq(list)
    end

    it "can set a player as not active if they fold" do
      list = PlayerCircle.create(players)
      list = PlayerCircle.fold(list)
      expect(list.has_folded).to be true
    end

    it "finds the next player that hasn't folded" do
      list = PlayerCircle.create(players)
      list = PlayerCircle.fold(list.next)
      list = list.prev
      list = PlayerCircle.find_next(list)
      expect(list.name).to eq('jake')
    end
  end
end
