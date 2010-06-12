require 'sinatra/base'
require 'haml'

class Quizzy < Sinatra::Base
  set :views, File.join(File.dirname(__FILE__), 'views')

  get '/' do
    haml :index
  end
end
