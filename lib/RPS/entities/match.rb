require 'killer_rps'

module RPS
  class Match
    attr_reader :player1_move, :player2_move, :player1_result, :player2_result

    def initialize(hash)
      @player1_move = hash[:player1_move]
      @player2_move = hash[:player2_move]
      result = KillerRPS.play({player1: @player1_move, player2: @player2_move})
      @player1_result = result[:player1]
      @player2_result = result[:player2]
      record_match
    end

    def record_match
      RPS.dbi.record_match(self)
    end

  end
end
# The Game class calls the Match class and passes player moves as a hash, eg: {player1_move: :rock, player2_move: :paper}
# The Match class will take in player moves and calulates a result. 
# The Match class calls DBI module to write the results of each match. 
# The Match class become a Match object with the resutls of the match, which the Game class uses.
# The Match object will be player1_move, player2_move, player1_result, player2_result