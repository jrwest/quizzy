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
  describe "scoring" do
    before(:each) do
      qanda = [
        {:text => "Question 1", :answer => "true"},
        {:text => "Question 2", :answer => "false"},
        {:text => "Question 3", :answer => "true"},
        {:text => "Question 4", :answer => "false"},
      ]
      @quiz = Quiz.create(:name => "A Quiz", :author => "whocares")
      qanda.each { |q|  @quiz.questions.create(q) }
      @question_ids = @quiz.questions.map { |q| q.id }
    end
    it "returns a 3-element array" do
      @quiz.score({}).size.should == 3
    end
    it "returns an array whose first element is a number" do
      @quiz.score({}).first.should be_instance_of Fixnum
    end
    it "returns an array whose second element is an array" do
      @quiz.score({})[1].should be_instance_of Array
    end
    it "returns an array whose third element is an array" do
      @quiz.score({}).last.should be_instance_of Array
    end
    context "all answers correct" do
      before(:each) do
        given_answers = ["true", "false", "true", "false"]
        @answers = {}
        @question_ids.each_with_index do |q_id, i|
          @answers[q_id] = given_answers[i]
        end
      end
      it "returns a score of 4" do
        @quiz.score(@answers).first.should == 4
      end
      it "returns a correct array containing all the question indexes" do
        @quiz.score(@answers)[1].should == [1, 2, 3, 4]
      end
      it "returns an empty wrong array" do
        @quiz.score(@answers).last.should == []
      end
    end
    context "some answers correct" do
      before(:each) do
        given_answers = ["true", "true", "false", "false"]
        @answers = {}
        @question_ids.each_with_index do |q_id, i|
          @answers[q_id] = given_answers[i]
        end
      end
      it "returns a score of 2" do
        @quiz.score(@answers).first.should == 2
      end
      it "returns a correct array with the indexes of the correct questions" do
        @quiz.score(@answers)[1].should == [1, 4]
      end
      it "returns a wrong array with the indexes of the incorrect questions" do
        @quiz.score(@answers).last.should == [2, 3]
      end
    end
    context "all answers wrong" do
      before(:each) do
        given_answers = ["false", "true", "false", "true"]
        @answers = {}
        @question_ids.each_with_index do |q_id, i|
          @answers[q_id] = given_answers[i]
        end
      end
      it "returns a score of 0" do
        @quiz.score(@answers).first.should == 0
      end
      it "returns an empty correct array" do
        @quiz.score(@answers)[1].should == []
      end
      it "returns an wrong array containing the indexes of all the questions" do
        @quiz.score(@answers).last.should == [1, 2, 3, 4]
      end
    end
  end
end
