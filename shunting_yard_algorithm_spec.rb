require './shunting_yard_algorithm'

describe ShuntingYardAlgorithm do

  it "returns empty for nil expression" do
    subject.post_fix(nil).should == ""
  end

  it "does nothing for empty expression" do
    subject.post_fix("").should == ""
  end

  it "does nothing for a single number" do
    subject.post_fix("1").should == "1"
    subject.post_fix("2").should == "2"
  end

  it "postfix simple add" do
    subject.post_fix("1 + 1").should == "1 1 +"
    subject.post_fix("2 + 2").should == "2 2 +"
  end

  it "postfix simple subtract" do
    subject.post_fix("1 - 1").should == "1 1 -"
  end

  it "postfix expression with multiple operators with same precedence" do
    subject.post_fix("1 + 2 + 3").should == "1 2 + 3 +"
    subject.post_fix("1 - 2 + 3").should == "1 2 - 3 +"
  end

end
