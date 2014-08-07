module RPS

  class InitGame

    def self.run(data)
      temp_game = RPS::Game.new(data)
      game = RPS.dbi.record_game(temp_game)
      game
    end
  end

  class PlayGame

    def self.run(game)
      if game.game_winner_id.nil?
        if ???game.turn == player1???
          match = RPS::Match.new(game_id, player1_move)
          ???game.turn = player2???
          RPS::DBI.record_match(match)
        else
          ???PULL MATCH RECORD FROM DATABASE AND STORE IN match???
          match.play(player2_move)
          RPS::DBI.record_match(match)
          game.check_winner?
        end
      else
    end
  end

end