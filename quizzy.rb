require 'sinatra/base'
require 'haml'
require 'sinatra/mongoid'

Dir[File.dirname(__FILE__) + '/models/*'].each { |f| require f }

class Quizzy < Sinatra::Base
  set :views, File.join(File.dirname(__FILE__), 'views')
  set :mongo_db, 'quizzy'

  get '/' do
    haml :index
  end

  get '/quizzes' do
    haml :quizzes
  end
end
