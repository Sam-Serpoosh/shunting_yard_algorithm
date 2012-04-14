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

  it "postfix expression of one number surrounded by parenthesis" do
    subject.post_fix("( 1 )").should == "1"
  end

  it "postfix expression of simple add within parenthesis" do
    subject.post_fix("( 1 + 2 )").should == "1 2 +"
  end

  it "postfix expression when parenthesis doesn't affect order of operations" do
    subject.post_fix("( 1 + 2 ) - 3").should == "1 2 + 3 -"
  end

  it "postfix expression when parenthesis affect order of operations" do
    subject.post_fix("( 1 + 2 ) * 3").should == "1 2 + 3 *"
    subject.post_fix("( 1 +    2   ) *   3 /   4").should == "1 2 + 3 * 4 /"
  end

  it "raises parenthesis mismatch when there's no open paren for a closed one" do
    expect do
      subject.post_fix("1 + 2 ) * 3")
    end.should raise_error(ParenthesisMismatch)
  end

  it "raises parenthesis mismatch when there's no close paren fo an opened one" do
    expect do
      subject.post_fix("( 1 + 2 * 3")
    end.should raise_error(ParenthesisMismatch)
  end

end
