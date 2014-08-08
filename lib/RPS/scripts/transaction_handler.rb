module RPS

  class InitGame

    def self.run(data)
      temp_game = RPS::Game.new(data)
      game = RPS.dbi.record_game(temp_game)
    end

  end

  class PlayGame

    def self.run(data)
      game = RPS.dbi.get_game_by_id(data['game_id'])
      while game.game_winner_id.nil?
        if game.turn == 'player1'
          match = RPS::Match.new({'game_id' => game.game_id, 'player1_move' => data['move']})
          game.turn = 'player2'
          RPS.dbi.update_game(game)
          RPS.dbi.record_match(match)
        else
          match = RPS.dbi.get_match_by_game_id(game.game_id)
          match.play(data['move'])
          RPS.dbi.update_match(match)
          game.turn = 'player1'
          game.check_winner
        end
      end
      RPS.dbi.update(game)
    end
  end

end