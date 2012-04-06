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

end
