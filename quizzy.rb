require 'sinatra'
require 'haml'
require 'mongoid'

Dir[File.dirname(__FILE__) + '/models/*.rb'].each { |f| require f }

set :views, File.join(File.dirname(__FILE__), 'views')
enable :sessions

Mongoid.database = Mongo::Connection.new.db('quizzy')

get '/' do
  haml :index
end

get '/quizzes' do
  @quizzes = Quiz.all
  haml :quizzes
end

post '/quizzes' do
  redirect_unless_authorized
  quiz = Quiz.create(params["quiz"].merge({"author" => session["account_name"]}))
  redirect "/quizzes/view/#{quiz.to_param}"
end

get '/quizzes/create' do
  redirect_unless_authorized
  haml :create_quiz
end

get '/quizzes/view/:name' do 
  @quiz = Quiz.from_param(params[:name])
  haml :quiz
end

post '/quizzes/view/:name' do 
  @quiz = Quiz.from_param(params[:name])
  if @quiz.questions.create(params["question"])
    redirect "/quizzes/view/#{@quiz.to_param}"
  else
    redirect "/quizzes/view/#{@quiz.to_param}/nq"
  end
end

get '/quizzes/view/:name/nq' do
  @quiz = Quiz.from_param(params[:name])
  haml :new_question
end

post '/accounts' do
  Account.create(params["account"])
  redirect '/'
end

get '/accounts/create' do
  haml :new_account
end

get '/login' do
  haml :login
end

post '/login' do
  if account = Account.authorize(params["username"], params["password"])
    session["account_name"] = account.name
    session["account_last_login"] = Time.now
    redirect '/quizzes'
  else
    redirect '/login?error=true'
  end
end

get '/logout' do
  session["account_name"] = nil
  session["account_last_login"] = nil
end

helpers do 
  def is_or_are(num)
    num == 1 ? "is" : "are"
  end

  def pluralize(word, num)
    num == 1 ? word : word.pluralize
  end

  def authorized?
    !(session["account_name"].nil?) && !(session["account_last_login"].nil?)
  end

  def redirect_unless_authorized
    redirect '/login' unless authorized?
  end
end

