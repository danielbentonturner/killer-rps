module RPS
end

require_relative 'RPS/entities/user.rb'
require_relative 'RPS/entities/match.rb'
require_relative 'RPS/entities/game.rb'
require_relative 'RPS/db/dbi.rb'
require_relative 'RPS/scripts/signin.rb'
require_relative 'RPS/scripts/signup.rb'
require_relative 'RPS/scripts/game_transaction.rb'
require_relative 'RPS/scripts/profile_transaction.rb'

