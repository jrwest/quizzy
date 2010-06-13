require 'sinatra'
require 'haml'
require 'mongoid'

Dir[File.dirname(__FILE__) + '/models/*'].each { |f| require f }

set :views, File.join(File.dirname(__FILE__), 'views')


Mongoid.database = Mongo::Connection.new.db('quizzy')

get '/' do
  haml :index
end

get '/quizzes' do
  @quizzes = Quiz.all
  haml :quizzes
end

post '/accounts' do
  Account.create(params["account"])
  redirect '/'
end

get '/accounts/create' do
  haml :new_account
end

helpers do 
  def is_or_are(num)
    num == 1 ? "is" : "are"
  end

  def pluralize(word, num)
    num == 1 ? word : word.pluralize
  end

end

