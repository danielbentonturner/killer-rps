require 'sinatra'
require 'rack-flash'
require 'killer_rps'
require 'pg'
require 'shotgun'
#require 'sinatra-authentication'
#require_relative 'lib/sesh.rb'

set :sessions, true
use Rack::Flash
#use Rack::Session::Cookie, :secret => 's3cret se$$ion key'


get '/' do
  erb :index  
end