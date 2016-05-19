class Deck < ActiveRecord::Base
  has_many :cards

  def self.suits
    %w(hearts diamonds clubs spades)
  end

  def self.card_values
    %w(ace 2 3 4 5 6 7 8 9 10 jack queen king)
  end

  def initialize(attributes = {})
    super
    Deck.suits.each do |suit|
      Deck.card_values.each do |val|
        cards << Card.new(value: val, suit: suit)
      end
    end
  end

  def size
    cards.length
  end

  def draw
    card = cards.sort.first
    cards.delete(cards.sort.first)
    return card
  end

  def shuffle
    pre_order_deck = pull_cards
    post_order_deck = order_swap(pre_order_deck)
    post_order_deck.each {|card| cards << card}
  end

  def pull_cards
    deck_ary = []
    deck_ary << draw while size > 0
    return deck_ary
  end

  def order_swap(pre_deck)
    post_deck = []
    rand_i = Random.new
    while pre_deck.length > 0
      index = rand_i.rand(pre_deck.length)
      post_deck << pre_deck[index]
      pre_deck.delete_at(index)
    end
    return post_deck
  end

end
