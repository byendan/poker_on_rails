class Table < ActiveRecord::Base
  has_one :dealer
  has_many :players

  include PlayerCircle 

  attr_accessor :user, :ai_count, :players_ary, :community_cards

  def initialize(options={})
    super
    ai_count = options[:ai_count] || 1
    load_players(options[:user], ai_count)
    load_dealer
    deal_cards

    self.community_cards = Array.new
  end

  def load_players(user, ai_count)
    self.user = user
    self.players_ary = Array.new
    while players.length < ai_count
      ai_name = Faker::Name.first_name
      add_player(ai_name) unless ai_name == self.user
    end
    add_player(self.user)
  end

  def load_dealer
    self.dealer = Dealer.new
  end

  def deal_cards
    hands_hash = dealer.distribute(self.players_ary)
    hands_hash.each do |player, hand|
      find_player(player.name).take_cards(hand)
    end
  end

  def add_player(name)
    player = Player.new(name: name)
    players << player
    self.players_ary << player
  end

  def find_player(name)
    self.players_ary.each do |player|
      return player if name == player.name
    end
  end

  def flop
    3.times {flip}
  end

  def flip
    self.community_cards << self.dealer.pass_card
  end

  def dealing_finished
    return self.community_cards.length > 4
  end

  def clear_community_cards
    self.dealer.take_cards(self.community_cards)
    self.community_cards = Array.new
  end

  def clear_player_cards
    self.players_ary.each {|player| self.dealer.take_cards(player.remove_cards)}
  end

  def clear_all_cards
    clear_community_cards
    clear_player_cards
  end

end
