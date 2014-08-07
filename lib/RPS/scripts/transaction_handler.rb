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
        match = RPS::Match.new(game_id, player1_move, player2_move)
        RPS::DBI.record_match(match)
        data[:game].determine_winner(match.result)
        return true
      end
        false
    end
  end

end