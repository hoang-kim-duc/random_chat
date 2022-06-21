# frozen_string_literal: true

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
      previous.next = self.next if previous
      self.next.previous = previous if self.next
      keeper
    end
  end
end
