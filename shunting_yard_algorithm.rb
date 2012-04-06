class ShuntingYardAlgorithm

  def initialize
    @output = ""
    @current_operator = nil
  end


  def post_fix(expression)
    return "" if expression.nil?
    return expression if expression.length <= 1

    tokens = expression.split(/ /)
    process_tokens(tokens) 
    append_token(@current_operator)

    @output[0..-2]
  end

  private

  def process_tokens(tokens)
    tokens.each do |token|
      if is_number?(token)
        append_token(token)
      else
        append_operator(token)
      end
    end
  end

  def is_number?(token)
    !!(token =~ /\d+/)
  end

  def append_token(token)
    @output += token + " "
  end

  def append_operator(token)
    @output += @current_operator + " " unless @current_operator.nil?
    @current_operator = token 
  end

end
