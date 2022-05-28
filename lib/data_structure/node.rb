module DataStructure
  class Node
    attr_accessor :next, :previous, :value

    def initialize(value, previous = nil, nextt = nil)
      @value = value
      @previous = previous
      @next = nextt
    end

    def puts_behind(node)
      node.next = self
      self.previous = node
    end

    def puts_front(node)
      node.previous = self
      self.next = node
    end

    def has_next?
      self.next.present?
    end

    def del_next_node
      keeper = @next
      @next = @next.next
      keeper
    end

    def del_self
      keeper = self
      self.previous.next = self.next
      keeper
    end
  end
end
