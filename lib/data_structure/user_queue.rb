# frozen_string_literal: true

module DataStructure
  class UserQueue
    attr_accessor :head, :tail, :enqueued_user

    def initialize
      reset
    end

    def reset
      @head = nil
      @tail = nil
      @enqueued_user = {}
    end

    def enqueue(node)
      Rails.logger.info("queued user_id #{node.user_id}")
      @enqueued_user[node.user_id] = node
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
      Rails.logger.info("dequeued user_id #{node.user_id}")
      @enqueued_user.delete node.user_id
      @head = node.next if @head == node
      @tail = node.previous if @tail == node
      if @head == @tail && @head == node
        pop_front
      elsif node.is_a? Node
        node.del_self
      end
    end

    def user_enqueued?(user_id)
      @enqueued_user[user_id]
    end

    def dequeue_by_user_id(user_id)
      return unless user_enqueued?(user_id)

      dequeue(@enqueued_user[user_id])
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
