require 'sinatra'
require 'rack-flash'
require 'killer_rps'
require 'pg'
require './lib/RPS.rb'
#require_relative 'lib/sesh.rb'

set :sessions, true
use Rack::Flash



get '/' do
  erb :index  
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
    redirect to '/sign_up'
  end
end

post '/signin' do
  sign_in = RPS::SignIn.run(params)

  if sign_in[:success?]
    session['sesh_example'] = sign_in[:session_id]
    redirect to '/'
  else
    flash[:alert] = sign_in[:error]
    redirect to '/signin'
  end
end

get '/signout' do
  session.clear
  redirect to '/'
end