module RPS

  class InitGame

    def self.run(data)
      temp_game = RPS::Game.new(data)
      game = RPS.dbi.record_game(temp_game)
    end

  end

  class PlayGame

    def self.run(data)
      game = RPS::DBI.get_game_by_id(data['game_id'])

      if game.game_winner_id.nil?
        if game.turn == 'player1'
          match = RPS::Match.new({'game_id' => game.game_id, 'player_move' => data['move']})
          game.turn = 'player2'
          RPS.dbi.update_game(game)
          RPS::DBI.record_match(match)
        else
          match = RPS::DBI.get_match_by_game_id(data['game_id'])
          match.play(match.player2_move)
          RPS::DBI.update_match(match)
          #game.check_winner?
        end
      end
    end
  end

end