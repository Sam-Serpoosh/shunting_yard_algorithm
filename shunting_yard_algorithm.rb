require './stack'

class ShuntingYardAlgorithm

  def post_fix(expression)
    init
    return "" if expression.nil?

    process(expression) 
    produce_output
  end

  private

  def init
    @output = []
    @operators = Stack.new
  end

  def process(expression)
    tokens = expression.split(/ /)
    process_tokens(tokens) 
    append_remaining_tokens
  end


  def process_tokens(tokens)
    tokens.each do |token|
      if is_number?(token)
        append_token(token)
      else
        append_operator(token)
      end
    end
  end

  def append_remaining_tokens
    while !@operators.empty?
      @output << @operators.pop
    end
  end

  def produce_output
    formatted_output = ""
    @output.each do |token|
      formatted_output += token + " "
    end
    formatted_output[0..-2]
  end

  def is_number?(token)
    !!(token =~ /\d+/)
  end

  def append_token(token)
    @output << token
  end

  def append_operator(token)
    while less_precedence(token)
      @output << @operators.pop unless @operators.empty? 
    end
    @operators.push(token)
  end

  def less_precedence(token)
    return false if @operators.empty?
    precedence(token) <= precedence(@operators.peek)
  end

  def precedence(token)
    if token == "+" || token == "-"
      return 1
    elsif token == "*" || token == "/"
      return 2
    end
    return 0
  end

end
