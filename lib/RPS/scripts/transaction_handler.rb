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
      p game.turn
      puts '---------------------'
      if game.game_winner_id.nil?
        if game.turn == :player1
          match = RPS::Match.new({'game_id' => game.game_id, 'player_move' => data['move']})
          game.turn = :player2
          RPS.dbi.record_match(match)
        else
          match = RPS.dbi.get_match_by_game_id(data['game_id'])
          p game.turn
          match.play(match.player2_move)
          RPS.dbi.update_match(match)
          #game.check_winner?
        end
      end
    end
  end

end