require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'database_connection_setup'
require_relative 'lib/space'

class MakersBnb < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions, :_methodoverride
  set :port, 4561


  get '/' do
    @result_db = Space.available_list
    $user_name
    erb :index
  end

  get '/space/new' do
    erb :'space/new'
  end

  post '/space' do
    name = params[:name]
    description = params[:description]
    price_per_night = params[:price_per_night]
    Space.create(name: name, description: description, price_per_night: price_per_night)
    redirect '/'
  end

  get '/user/new' do
    erb :'user/new'
  end

  post '/user' do
    $username = params[:user_name]
    $email = params[:email]
    $password = params[:password]
    redirect '/'
  end

  get '/user/sign_in' do
    erb :'user/sign_in'
  end

  patch '/user/:id' do
    p $username
    $email = params[:email]
    redirect '/'
  end

  

  run! if app_file == $PROGRAM_NAME
end
