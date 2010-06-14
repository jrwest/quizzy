class Question
  include Mongoid::Document

  field :text
  field :answer

  validates_presence_of :text
  validates_format_of :answer, :with => /^(true|false)$/

  embedded_in :quiz, :inverse_of => :questions
end
