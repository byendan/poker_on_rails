module PlayerCircle
  class PlayerNode
    attr_accessor :name, :player, :next, :prev, :is_dealer, :is_last, :has_folded
    def initialize(player)
      self.name = player.name
      self.player = player
      self.next = nil
      self.prev = nil
      self.is_dealer = false
      self.is_last = false
      self.has_folded = false
    end
  end

  def self.create(players)
    p_nodes = convert_to_nodes(players)
    for i in 0...p_nodes.length
      p_nodes[i].prev = p_nodes[i-1]
      p_nodes[i] != p_nodes.last ? p_nodes[i].next = p_nodes[i+1] : p_nodes[i].next = p_nodes[0]
    end
    return p_nodes.first
  end

  def self.convert_to_nodes(players)
    return_nodes = []
    players.each {|player| return_nodes << PlayerNode.new(player)}
    return_nodes.first.is_dealer = true
    return_nodes.last.is_last = true
    return_nodes
  end

  def self.shift(list)
    list.is_dealer = false
    list.next.is_dealer = true
    return list.next
  end

  def self.fold(list_node)
    list_node.has_folded = true
    return list_node
  end

  def self.find_next(list)
    list = list.next
    while list.has_folded
      list = list.next
    end
    return list 
  end

end
