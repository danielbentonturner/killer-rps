module RPS

  class InitGame

    def self.run(data)
      temp_game = RPS::Game.new(data)
      game = RPS.dbi.record_game(temp_game)
    end

  end

  class PlayGame

    def self.run(data)
      game = RPS::DBI.get_game_by_id(data[:game_id])
      if game.game_winner_id.nil?
        if game.turn == :player1
          match = RPS::Match.new(game_id, data[:move].to_sym)
          game.turn = :player2
          RPS::DBI.record_match(match)
        # else
          # ???PULL MATCH RECORD FROM DATABASE AND STORE IN match???
          # match.play(player2_move)
          # RPS::DBI.record_match(match)
          # game.check_winner?
        end
      end
    end
  end

end