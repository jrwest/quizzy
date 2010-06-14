class Quiz
  include Mongoid::Document

  field :name
  field :author

  validates_presence_of :name
  validates_format_of :name, :with => /^([a-z]+\s*)+$/i

  embeds_many :questions

  # Takes a hash of answers. Each hash key is a BSON question id
  # Returns an array of 3 elements. The first is a number representing
  # correct answers. The second is an array of indexes which are the correct
  # questions. The third is an array of indexes which are the wrong answers
  def score(answers)
    index = 1
    score = questions.inject([0, [], []]) do |score, question|
      if question.answer == answers[question.id]
        score[0] += 1
        score[1] << index
      else
        score[2] << index
      end
      index += 1
      score
    end
    score
  end
  
  def to_param
    name.split(' ').map { |w| w.downcase }.join('-')
  end

  def self.from_param(text)
    first(:conditions => {:name => text.split('-').map { |w| w.capitalize }.join(' ')})
  end
end
