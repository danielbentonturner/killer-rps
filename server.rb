require 'sinatra'
require 'rack-flash'
require 'killer_rps'
require 'pg'
require './lib/RPS.rb'
#require_relative 'lib/sesh.rb'

set :sessions, true
use Rack::Flash



get '/' do
  if session['sesh_example']
    @user = RPS.dbi.get_user_by_username(session['sesh_example'])
    redirect to '/profile'
  end
  erb :index  
end

get '/signin' do
  erb :signin
end

get '/signup' do
  if session['sesh_example']
    redirect to '/'
  else
    erb :signup
  end
end

post '/signup' do
  sign_up = RPS::SignUp.run(params)

  if sign_up[:success?]
    session['sesh_example'] = sign_up[:session_id]
    redirect to '/signin'
  else
    flash[:alert] = sign_up[:error]
    redirect to '/signup'
  end
end

post '/signin' do
  sign_in = RPS::SignIn.run(params)
  if sign_in[:success?]
    session['sesh_example'] = sign_in[:session_id]
    redirect to "/profile"
  else
    flash[:alert] = sign_in[:error]
    redirect to '/signin'
  end
end

get '/signout' do
  session.clear
  redirect to '/'
end

get '/profile' do
  @user = RPS.dbi.get_user_by_username(session['sesh_example'])
  erb :profile
end

get '/startgame/:player1_id/:player2_id' do
  puts params
  puts "!!!!!!!!!!!!!!!!!!!!"
  startgame = RPS::InitGame.run(params)
  puts startgame.game_id
  redirect to "/game/#{startgame.game_id}"
end

get '/game/:game_id' do
  p1_for_game = RPS.dbi.get_game_by_id(params['game_id']).player1_id
  p1_username = RPS.dbi.get_user_by_id(params[p1_for_game]).username
  @player1 = session['sesh_example'] == p1_username ? true:false
  puts @player1
  puts "-==-=-================="
  erb :game
end

get '/game/:game_id/play/:move' do
  @play = RSP::PlayGame.run(params)
  redirect to "/game/#{params['game_id']}"
end
