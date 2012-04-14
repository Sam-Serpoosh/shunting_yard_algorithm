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
    tokens = extract_tokens(expression) 
    process_tokens(tokens) 
    append_remaining_tokens
  end

  def extract_tokens(expression)
    tokens = expression.split(/ /)
    filter_tokens(tokens)
  end


  def filter_tokens(tokens)
    filtered_tokens = []
    tokens.each do |token|
      filtered_tokens << token if !token.empty? 
    end
    filtered_tokens
  end

  def process_tokens(tokens)
    tokens.each do |token|
      if token == "("
        @operators.push("(")
      elsif token == ")"
        balance_parenthesis
      elsif is_number?(token)
        append_token(token)
      else
        append_operator(token)
      end
    end
  end

  def append_remaining_tokens
    while !@operators.empty?
      token = @operators.pop
      raise ParenthesisMismatch if token.eql?("(")
      @output << token 
    end
  end

  def produce_output
    formatted_output = ""
    @output.each do |token|
      formatted_output += token + " "
    end
    formatted_output[0..-2]
  end

  def balance_parenthesis
    while !@operators.empty? && !@operators.peek.eql?("(") 
      append_token(@operators.pop)
    end
    raise ParenthesisMismatch if @operators.empty?
    @operators.pop
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

class ParenthesisMismatch < Exception
end
