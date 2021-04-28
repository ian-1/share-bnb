require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'database_connection_setup'
require_relative 'lib/space'

class MakersBnb < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions

  get '/' do
    @result_db = Space.all.last
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

  # get '/user/new' do
  #
  # end

  run! if app_file == $PROGRAM_NAME
end
