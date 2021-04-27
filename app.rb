require 'sinatra/base'
require 'sinatra/reloader'
# require_relative 'database_connection_setup'

class MakersBnb < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions

  get '/' do
    p $name
    p $description
    p $price_per_night
    erb :index 
  end

  get '/space/new' do
    erb :'space/new'
  end

  post '/space' do
    $name = params[:name]
    $description = params[:description]
    $price_per_night = params[:price_per_night]
    redirect '/'
  end
  run! if app_file == $PROGRAM_NAME
end
