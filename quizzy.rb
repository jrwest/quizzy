require 'sinatra/base'

class Quizzy < Sinatra::Base
  get '/' do
    'Hello Quizzy!'
  end
end
