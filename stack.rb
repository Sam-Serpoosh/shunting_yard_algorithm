class Stack

  attr_reader :size

  def initialize
    @elements = []
    @size = 0
  end

  def empty?
    @size == 0
  end

  def push(element)
    @elements[@size] = element
    @size += 1
  end

  def pop
    raise UnderFlowException if empty?
    @size -= 1
    @elements[@size]
  end

end


class UnderFlowException < Exception
end
