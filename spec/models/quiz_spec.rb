require 'spec_helper'
require 'quiz'

describe Quiz do
  it "is not valid with an empty quiz name" do
    Quiz.new(:name => "").should_not be_valid
  end
  it "is not valid with a name that starts with a space" do
    Quiz.new(:name => " Quiz Name").should_not be_valid
  end
  it "is not valid with a name that does not contain only names and spaces" do
    ["Quiz1", "Quiz/", "quiz-name"].each do |quiz_name|
     Quiz.new(:name => quiz_name).should_not be_valid
    end
  end
  describe "#to_param" do
    it "converts the quiz name to a dash seperated, lower case string" do
      quiz = Quiz.create(:name => "Some Quiz Name")
      quiz.to_param.should == "some-quiz-name"
    end
  end
  describe "from parameter" do
    it "it returns the Quiz instance" do
      quiz = Quiz.create(:name => "Some Quiz Name")
      Quiz.from_param("some-quiz-name").should == quiz
    end
  end
end
