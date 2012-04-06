require './stack'

describe Stack do

  it "is empty at creation" do
    subject.should be_empty
  end

  it "has one element after one push" do
    subject.push(1)
    subject.size.should == 1
    subject.should_not be_empty
  end
  
  it "has two elements after two pushes" do
    subject.push(1)
    subject.push(2)
    subject.size.should == 2
  end

  it "is empty after one push and one pop" do
    subject.push(1)
    subject.pop
    subject.should be_empty
  end

  it "has one element after two pushes and one pop" do
    subject.push(1)
    subject.push(2)
    subject.pop
    subject.size.should == 1
  end

  it "raises under flow exception if pop from empty stack" do
    expect do
      subject.pop
    end.should raise_error(UnderFlowException)
  end

  it "pops the last pushed element" do
    subject.push(1)
    subject.pop.should == 1
    subject.should be_empty
  end

  it "pops elements in reverse order thy were pushed" do
    subject.push(1)
    subject.push(2)
    subject.pop.should == 2
    subject.pop.should == 1
  end

  it "peeks the top element" do
    subject.push(1)
    subject.peek.should == 1
    subject.size.should == 1
  end

  it "raises empty stack exception when peek from empty stack" do
    expect do
      subject.peek
    end.should raise_error(EmptyStackException)
  end

end
