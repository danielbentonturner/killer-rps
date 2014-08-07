module RPS

  class HandleGame

    def self.start_game(data)
      temp_game = RPS::  Game.new(data)
      game = RPS.dbi.record_game(temp_game)
      params = {game:game}
    end

    def self.play_game(data)
      if !data[:game].game_winner_id
        match = Match.new(game_id, player1_move, player2_move)
        data[:game].determine_winner(match.result)
        return true
      end
        false
    end

  end

end