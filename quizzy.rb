require 'sinatra'
require 'haml'
require 'mongoid'
require 'hyper_graph'

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
  redirect_unless_authorized
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

post '/quizzes/score' do
  @quiz = Quiz.first(:conditions => {:name => params["quiz_name"]})
  @score = @quiz.score(params["answers"])
  @percent_correct = ((@score.first.to_f / @quiz.questions.count.to_f) * 100).to_i.to_s + "%"
  session[:last_score] = @percent_correct
  session[:last_quiz] = @quiz.name
  haml :score
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

get '/post' do
  redirect_unless_was_quizzed
  redirect HyperGraph.authorize_url(facebook_api["client_id"], 
                                    facebook_api["redirect_uri"], :scope => facebook_api["scope"], :display => facebook_api["display"])
end

get '/perform_post' do
  redirect '/quizzes' if session[:fb_access_token].nil?
  graph = HyperGraph.new(session[:fb_access_token])
  graph.post('me/feed', :message => "I took the Quizzy Quiz #{session[:last_quiz]} and scored a #{session[:last_score]}")
  redirect '/post_complete'
end

get '/post_complete' do
  "Your Post is Complete <a href='/quizzes'>Take Another</a>"
end

get '/callback' do
  session[:fb_access_token] = HyperGraph.get_access_token(facebook_api["client_id"], 
                                                          facebook_api["client_secret"], 
                                                          facebook_api["redirect_uri"], 
                                                          params["code"])
  redirect '/perform_post'
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

  def was_quizzed?
    !(session[:last_quiz].nil?) && !(session[:last_score].nil?)
  end

  def redirect_unless_was_quizzed
    redirect '/quizzes' unless was_quizzed?
  end

  def facebook_api
    @facebook_api ||= YAML::load_file('fb.yml')
  end
end

