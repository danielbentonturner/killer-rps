require 'sinatra'
require 'rack-flash'
require 'killer_rps'
#require_relative 'lib/sesh.rb'

set :sessions, true
use Rack::Flash

get '/' do
  erb :index  
end