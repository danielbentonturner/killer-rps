require 'sinatra'
require 'rack-flash'
require 'killer_rps'
require 'pg'
require './lib/RPS.rb'
#require_relative 'lib/sesh.rb'

set :sessions, true
use Rack::Flash



get '/' do
  if session['k1ll3r_RPS']
    @user = RPS.dbi.get_user_by_username(session['k1ll3r_RPS'])
    redirect to '/profile'
  end
  erb :index  
end

get '/signin' do
  erb :signin
end

get '/signup' do
  if session['k1ll3r_RPS']
    redirect to '/'
  else
    erb :signup
  end
end

post '/signup' do
  sign_up = RPS::SignUp.run(params)

  if sign_up[:success?]
    session['k1ll3r_RPS'] = sign_up[:session_id]
    redirect to '/profile'
  else
    flash[:alert] = sign_up[:error]
    redirect to '/signup'
  end
end

post '/signin' do
  sign_in = RPS::SignIn.run(params)
  if sign_in[:success?]
    session['k1ll3r_RPS'] = sign_in[:session_id]
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
  @user = RPS.dbi.get_user_by_username(session['k1ll3r_RPS'])
  @game_hash = RPS::GameLookup.run(@user)
  @match_hash = RPS::MatchLookup.run(@game_hash)
  erb :profile
end

get '/startgame/:player1_id/:player2_id' do
  startgame = RPS::InitGame.run(params)
  redirect to "/game/#{startgame.game_id}"
end

get '/game/:game_id' do
  count = 0
  game = RPS.dbi.get_game_by_id(params['game_id'])
  sess_user = RPS.dbi.get_user_by_username(session['k1ll3r_RPS'])
  p2_for_game = game.player2_id
  p1_for_game = game.player1_id
  @p1_username = RPS.dbi.get_user_by_id(p1_for_game).username
  @p2_username = RPS.dbi.get_user_by_id(p2_for_game).username
  @player1 = session['k1ll3r_RPS'] == @p1_username ? true:false
  # erb :game
  if game.game_winner_id == sess_user.user_id
    redirect to '/game/result/winner'
    game.game_status = 'complete'
  elsif !game.game_winner_id.nil?
    redirect to '/game/result/loser'
  else
    erb :game
  end
end

get '/game/:game_id/play/:move' do
  params['sesh_name'] = session['k1ll3r_RPS']
  if RPS::PlayGame.run(params)
    redirect to "/"
  else
    redirect to "/game/play/err/wrong_turn"
  end
end

get '/game/result/winner' do
  erb :winner
end

get '/game/result/loser' do
  erb :loser
end

get '/game/play/err/wrong_turn' do
  erb :wrong_turn
end

get '/moo' do
  erb :moo
end