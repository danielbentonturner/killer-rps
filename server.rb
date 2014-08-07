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
    redirect to '/'
  else
    flash[:alert] = sign_up[:error]
    redirect to '/signup'
  end
end

post '/signin' do
  sign_in = RPS::SignIn.run(params)
  puts "----------------------"

  puts sign_in[:success?]
  puts sign_in[:session_id]
  puts "----------------------"
  if sign_in[:success?]
    session['sesh_example'] = sign_in[:session_id]
    redirect to '/'
  else
    puts 'here'
    flash[:alert] = sign_in[:error]
    redirect to '/signin'
  end
end

get '/signout' do
  session.clear
  redirect to '/'
end

# get '/'