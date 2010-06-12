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
  haml :quizzes
end

