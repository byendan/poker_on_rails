class Dealer < ActiveRecord::Base
  has_many :decks
  attr_accessor :master_deck


  def initialize(options={})
    super
    6.times do
      deck = Deck.new
      deck.shuffle
      decks << deck
    end
    @master_deck = consolidate_decks
  end

  def draw_deck
    deck = decks.sort.first
    decks.delete(decks.sort.first)
    return deck
  end

  def pull_decks
    deck_ary = []
    deck_ary << draw_deck while size > 0
    return deck_ary
  end

  def size
    decks.length
  end

  def consolidate_decks
    final_deck = []
    pull_decks.each do |deck|
      deck.pull_cards.each {|card| final_deck << card }
    end
    return final_deck
  end

  def shuffle_decks
    post_master_deck = []
    random_index_generator = Random.new
    while master_deck.length > 0
      random_index = random_index_generator.rand(@master_deck.length)
      post_master_deck << @master_deck[random_index]
      @master_deck.delete_at(random_index)
    end
    @master_deck = post_master_deck
  end
end
