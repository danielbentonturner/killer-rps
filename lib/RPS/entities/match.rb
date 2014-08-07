require 'killer_rps'

module RPS
  class Match
    attr_reader :game_id, :player1_move, :player2_move, :result

    def initialize(game_id, player1_move)
      @game_id = game_id
      @player1_move = player1_move
      @player2_move = nil
      @result = nil
    end

    def play(player2_move)
      @result = KillerRPS.play({player1: @player1_move, player2: @player2_move})
  end
end