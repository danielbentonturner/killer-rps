require 'killer_rps'

module RPS
  class Match
    attr_reader :game_id, :player1_move, :player2_move, :result

    def initialize(game_id, player1_move)
      @player1_move = hash[:player1_move]
      @player2_move = hash[:player2_move]
      result = KillerRPS.play({player1: @player1_move, player2: @player2_move})
      @player1_result = result[:player1]
      @player2_result = result[:player2]
    end

  end
end