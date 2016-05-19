class Card < ActiveRecord::Base
  belongs_to :deck

  valid_suits = ["hearts", "diamonds", "spades", "clubs"]

  # Hash that translates the card value to a numeric value
  def self.value_hash
    return {
      'ace' => 1, '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7,
       '8' => 8, '9' => 9, '10' => 10, 'jack' => 11, 'queen' => 12, 'king' => 13
    }
  end


  validates :value, presence: true, inclusion: {in: self.value_hash.keys.map(&:to_s)}
  validates :suit, presence: true, inclusion: { in: valid_suits }

  def numeric_value
    card_value = self[:value]
    return Card.value_hash[card_value]
  end



end
