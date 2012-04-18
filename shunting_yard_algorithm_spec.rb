require './shunting_yard_algorithm'

describe ShuntingYardAlgorithm do

  it "returns empty for nil expression" do
    subject.post_fix(nil).should == ""
  end

  it "does nothing for empty expression" do
    subject.post_fix("").should == ""
  end

  it "does nothing for empty spaces" do
    subject.post_fix("   ").should == ""
  end

  it "does nothing for a single number" do
    subject.post_fix("1").should == "1"
    subject.post_fix("2").should == "2"
  end

  it "postfix simple add" do
    subject.post_fix("1 + 1").should == "1 1 +"
    subject.post_fix("2 + 2").should == "2 2 +"
  end

  it "ignores multiple spaces between tokens" do
    subject.post_fix("1  +     2").should == "1 2 +"
  end

  it "postfix simple subtract" do
    subject.post_fix("1 - 1").should == "1 1 -"
  end

  it "postfix expression with multiple operators with same precedence" do
    subject.post_fix("1 + 2 + 3").should == "1 2 + 3 +"
    subject.post_fix("1 - 2 + 3").should == "1 2 - 3 +"
  end

  it "postfix expression with two operators with different precedence" do
    subject.post_fix("1 + 2 * 3").should == "1 2 3 * +"
    subject.post_fix("1 - 2 / 3").should == "1 2 3 / -"
  end

  it "postfix expression with multiple operators with different precedences" do
    subject.post_fix("1 + 2 * 3 + 4").should == "1 2 3 * + 4 +"
    subject.post_fix("1 + 2 * 3 + 4 / 5").should == "1 2 3 * + 4 5 / +"
  end

  it "postfix expression of one number surrounded by parentheses" do
    subject.post_fix("( 1 )").should == "1"
  end

  it "postfix expression of simple add within parentheses" do
    subject.post_fix("( 1 + 2 )").should == "1 2 +"
  end

  it "postfix expression when parentheses doesn't affect order of operations" do
    subject.post_fix("( 1 + 2 ) - 3").should == "1 2 + 3 -"
  end

  it "postfix expression when parentheses affect order of operations" do
    subject.post_fix("( 1 + 2 ) * 3").should == "1 2 + 3 *"
    subject.post_fix("( 1 +    2   ) *   3 /   4").should == "1 2 + 3 * 4 /"
  end

  it "raises parentheses mismatch when there's no open paren for a closed one" do
    expect do
      subject.post_fix("1 + 2 ) * 3")
    end.should raise_error(ParenthesesMismatch)
  end

  it "raises parentheses mismatch when there's no close paren fo an opened one" do
    expect do
      subject.post_fix("( 1 + 2 * 3")
    end.should raise_error(ParenthesesMismatch)
  end

  it "postfix function call with no argument" do
    subject.post_fix("f ( )").should == "f"
  end

  it "postfix function call with one argument" do
    subject.post_fix("f ( 1 )").should == "1 f"
  end

  it "postfix function call with two arguments" do
    subject.post_fix("f ( 1 , 2 )").should == "1 2 f"
  end

  it "raises parentheses mismatch exception when parentheses are not matched in function call" do
    expect do
      subject.post_fix("f ( 1 , 2")
    end.should raise_error(ParenthesesMismatch)

    expect do
      subject.post_fix("f 1 , 2 )")
    end.should raise_error(ParenthesesMismatch)
  end

  it "postfix when argument of a function is expression itself" do
    subject.post_fix("f ( 1 + 2 )").should == "1 2 + f"
  end

  it "postfix when arguments of a function are expression themselves" do
    subject.post_fix("f ( 1 + 2 * 3 , 4 - 2 / 1 )").should == "1 2 3 * + 4 2 1 / - f"
  end

  it "postfix when argument of a function is function itself" do
    subject.post_fix("f ( g ( 1 ) )").should == "1 g f"
  end

  it "postfix function call with other function calls as arguments" do
    subject.post_fix("f ( g ( 1 + 3 * 2 ) , 4 - 2 / 1 )").should == "1 3 2 * + g 4 2 1 / - f"
  end

end
