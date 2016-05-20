class Player < ActiveRecord::Base
  has_many :cards
  attr_accessor :money, :hand, :name

  def initialize(options={})
    super
    self.money = options[:money] || 200
    self.name = options[:name] || ''
  end

  def bet(ammount)
    self.money -= ammount if ammount <= self.money
  end

  def win(ammount)
    self.money += ammount
  end

  def all_in
    total_bet = self.money
    self.money = 0
    return total_bet
  end

  def active?
    self.money > 0
  end

  def take_cards(hand)
    self.hand = hand
    hand.each {|card| self.cards << card }
  end

  def remove_cards
    give_back_cards = hand
    hand = Array.new()
    while self.cards.length > 0
      self.cards.delete(self.cards.sort.first)
    end
    give_back_cards
  end
end
