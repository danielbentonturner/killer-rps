require 'killer_rps'

module RPS
  class Match

    attr_reader :match_id, :game_id, :player1_move, :player2_move, :result

    def initialize(data)
      @match_id = data['id']||nil
      @game_id = data['game_id']
      @player1_move = data['player1_move']
      @player2_move = data['player2_move']||nil
      @result = data['result'] || nil
    end

    def play(move)
      @player1_move = @player1_move.to_sym
      @player2_move = move.to_sym
      @result = KillerRPS.play({player1: @player1_move, player2: @player2_move})
      puts ")))))))))))))))))))))))))))))))))"
      p @result
      puts ")))))))))))))))))))))))))))))))))"
    end
  end
end