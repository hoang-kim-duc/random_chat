module DataStructure
  class UserQueue
    attr_accessor :head, :tail, :enqueued_user

    def initialize
      @head = nil
      @tail = nil
      @enqueued_user = {}
    end

    def enqueue(node)
      @enqueued_user[node.user_id] = true
      if @head
        keeper = @tail
        @tail = node
        @tail.puts_behind(keeper)
      else
        @head = node
        @tail = node
      end
    end

    def dequeue(node)
      @enqueued_user.delete node.user_id
      if node == @head
        return pop_front
      elsif node.is_a? Node
        return node.del_self
      end
    end

    def user_enqueued?(user_id)
      @enqueued_user[user_id]
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

    def clear!
      @head = nil
      @tail = nil
      @enqueued_user = {}
    end

    def size
      count = 0
      node = @head
      while node.present?
        count += 1
        node = node.next
      end
      count
    end
  end
end
