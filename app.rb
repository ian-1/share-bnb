require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'
require_relative 'database_connection_setup'
require_relative 'lib/space'
require_relative 'lib/user'

class MakersBnb < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    register Sinatra::Flash
  end

  enable :sessions, :method_override
  set :port, 4561

  get '/' do
    @result_db = Space.available_list
    @user = User.find(id: session[:user_id]) unless session[:user_id].nil?
    erb :index
  end

  get '/space/new' do
    erb :'space/new'
  end

  post '/space' do
    unless session[:user_id].nil?
      name = params[:name]
      description = params[:description]
      price_per_night = params[:price_per_night]
      user_id = session[:user_id] 
      Space.create(name: name, description: description, price_per_night: price_per_night, user_id: user_id )
    end
    redirect '/'
  end

  get '/user/new' do
    erb :'user/new'
  end

  post '/user' do
    username = params[:user_name]
    email = params[:email]
    password = params[:password]
    user = User.create(name: username, email: email, password: password)
    session[:user_id] = user.id
    redirect '/'
  end

  get '/user/sign_in' do
    erb :'user/sign_in'
  end

  patch '/user/:id' do
    user = User.authenticate(email: params[:email], password: params[:password])
    if user
      session[:user_id] = user.id
      redirect '/'
    else
      flash[:wrong_details] = 'Please check your email or password.'
      redirect '/user/sign_in'
    end
  end

  post '/user/sign_out' do
    session[:user_id] = nil
    redirect '/'
  end

  patch '/space/:id' do
    flash[:not_signed_in] = 'Please sign in or sign up before booking' if session[:user_id].nil?
    id = params[:id]
    space = Space.find(id: id)
    space.unavailable unless session[:user_id].nil?
    redirect '/'
  end
 
  run! if app_file == $PROGRAM_NAME
end
