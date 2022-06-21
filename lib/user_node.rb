# frozen_string_literal: true

class UserNode < DataStructure::Node
  attr_accessor :selected
  alias user_id value
  alias user_id= value=

  def initialize(*args)
    selected = false
    super(*args)
  end
end
