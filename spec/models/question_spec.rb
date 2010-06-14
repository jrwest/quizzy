require 'spec_helper'
require 'quiz'
require 'question'

describe Question do
  before(:each) do
    @quiz = Quiz.create(:name => "Some Quiz", :author => "someauthor")
  end
  it "can be created with valid attributes" do
    @quiz.questions.create(:text => "This is some question text", :answer => "true")
    @quiz.questions.create(:text => "This is some question text", :answer => "false")
  end
  it "is invalid with empty question text" do 
    @quiz.questions.build(:text => "", :answer => "true").should_not be_valid
  end
  it "is invalid with an answer other than true or false" do
    @quiz.questions.build(:text => "This is some question text", :answer => "nottrue").should_not be_valid
  end
end
