class ShuntingYardAlgorithm

  def post_fix(expression)
    return "" if expression.nil?
    return expression if expression.length <= 1
    tokens = expression.split(/ /)
    tokens[0] + " " + tokens[2] + " " + tokens[1] 
  end

end
