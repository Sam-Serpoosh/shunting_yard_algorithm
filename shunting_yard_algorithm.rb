class ShuntingYardAlgorithm

  def post_fix(expression)
    return "" if expression.nil?
    return expression if expression.length <= 1
    tokens = expression.split(/ /)
    output = ""
    operator = nil
    tokens.each do |token|
      if is_number?(token)
        output += token + " "
      else
        output += operator + " " unless operator.nil?
        operator = token
      end
    end
    output += operator 
    output
  end

  private
  def is_number?(token)
    number_pattern = /\d+/
    !!(token =~ number_pattern)
  end

end
