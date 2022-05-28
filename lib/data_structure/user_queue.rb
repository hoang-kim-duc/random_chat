module DataStructure
  class UserQueue
    attr_accessor :head, :tail

    def initialize
      @head = nil
      @tail = nil
    end

    def enqueue node
      if @head
        keeper = @tail
        @tail = node
        @tail.puts_behind(keeper)
      else
        @head = node
        @tail = node
      end
    end

    def dequeue node
      if node == @head
        return pop_front
      elsif node.is_a? Node
        return node.del_self
      end
    end

    def pop_front
      @head = @head.next if @head
    end

    def print
      node = @head
      puts node.user_id
      while (node = node.next)
        puts node.user_id
      end
    end
  end
end
