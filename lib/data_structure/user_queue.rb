module DataStructure
  class UserQueue
    attr_accessor :head, :tail, :processing_node, :current_node

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

    def process_next_node
      @processing_node = @head
      pop_front
      @current_node = @head
      @processing_node
    end

    def travel_forward
      @current_node = @current_node.next if @current_node
    end

    def travel_backward
      @current_node = @current_node.previous if @current_node
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
