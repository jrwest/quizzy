class Quiz
  include Mongoid::Document

  field :name
  field :author

  validates_presence_of :name
  validates_format_of :name, :with => /^([a-z]+\s*)+$/i

  def to_param
    name.split(' ').map { |w| w.downcase }.join('-')
  end

  def self.from_param(text)
    first(:conditions => {:name => text.split('-').map { |w| w.capitalize }.join(' ')})
  end
end
