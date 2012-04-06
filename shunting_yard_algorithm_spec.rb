require './shunting_yard_algorithm'

describe ShuntingYardAlgorithm do

  it "returns empty for nil expression" do
    algorithm.post_fix(nil).should == ""
  end

  it "does nothing for empty expression" do
    algorithm.post_fix("").should == ""
  end

  it "does nothing for a single number" do
    algorithm.post_fix("1").should == "1"
    algorithm.post_fix("2").should == "2"
  end

  it "postfix simple add" do
    algorithm.post_fix("1 + 1").should == "1 1 +"
    algorithm.post_fix("2 + 2").should == "2 2 +"
  end

  it "postfix simple subtract" do
    algorithm.post_fix("1 - 1").should == "1 1 -"
  end

  it "postfix expression with multiple operators with same precedence" do
    algorithm.post_fix("1 + 2 + 3").should == "1 2 + 3 +"
    algorithm.post_fix("1 - 2 + 3").should == "1 2 - 3 +"
  end

  it "postfix expression with two operators with different precedence" do
    algorithm.post_fix("1 + 2 * 3").should == "1 2 3 * +"
    algorithm.post_fix("1 - 2 / 3").should == "1 2 3 / -"
  end

  def algorithm
    ShuntingYardAlgorithm.new
  end

end
