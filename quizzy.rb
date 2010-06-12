require 'sinatra'
require 'haml'
require 'mongoid'

Dir[File.dirname(__FILE__) + '/models/*'].each { |f| require f }

set :views, File.join(File.dirname(__FILE__), 'views')

Before do 
  Mongoid.database = Mongo::Connection.new.db('quizzy')
end

get '/' do
  haml :index
end

get '/quizzes' do
  @quizzes = Quiz.all
  haml :quizzes
end

helpers do 
  def is_or_are(num)
    num == 1 ? "is" : "are"
  end

  def pluralize(word, num)
    num == 1 ? word : word.pluralize
  end

end

