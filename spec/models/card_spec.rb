require 'rails_helper'

RSpec.describe Card, type: :model do


  describe "cards must be valid french style playing cards" do

    it "is valid if a card has both value and suit" do
      card = Card.new(value: '5',suit: 'diamonds')
      expect(card).to be_valid
    end

    it "is not valid without a value" do
      card = Card.new(suit: 'spades')
      expect(card).not_to be_valid
    end

    it "is not valid without a suit" do
      card = Card.new(value: '5')
      expect(card).not_to be_valid
    end

    it "will be valid if suit is hearts, diamonds, spades, or clubs" do
      heart = Card.new(value: 'ace', suit: 'hearts')
      diamond = Card.new(value: '2', suit: 'diamonds')
      spade = Card.new(value: '3', suit: 'spades')
      club = Card.new(value: '4', suit: 'clubs')
      expect(heart).to be_valid
      expect(diamond).to be_valid
      expect(spade).to be_valid
      expect(club).to be_valid
    end

    it "will be invalid to have suits of the wrong name" do
      invalid_1 = Card.new(value: 'ace', suit: 'bla')
      invalid_2 = Card.new(value: '2', suit: 'clubles')
      expect(invalid_1).not_to be_valid
      expect(invalid_2).not_to be_valid
    end

    it "will be valid with a value between ace and king" do
      ace = Card.new(value: 'ace', suit: 'hearts')
      three = Card.new(value: '3', suit: 'hearts')
      queen = Card.new(value: 'queen', suit: 'hearts')
      expect(ace).to be_valid
      expect(three).to be_valid
      expect(queen).to be_valid
    end

    it "will be invalid with any other value" do
      invalid_1 = Card.new(value: 'bla', suit: 'hearts')
      invalid_2 = Card.new(value: 'joker', suit: 'hearts')
      expect(invalid_1).not_to be_valid
      expect(invalid_2).not_to be_valid
    end
  end

  describe "cards function properly" do
    it "gives a numberical value when asked for it" do
      ace = Card.new(value: 'ace')
      five = Card.new(value: '5')
      king = Card.new(value: 'king')
      expect(ace.numeric_value).to eq(1)
      expect(five.numeric_value).to eq(5)
      expect(king.numeric_value).to eq(13)
    end
  end
end
