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
      if game.game_winner_id.nil?
        if game.turn == 'player1'
          match = RPS::Match.new({'game_id' => game.game_id, 'player1_move' => data['move']})
          game.turn = 'player2'
          RPS.dbi.update_game(game)
          RPS.dbi.record_match(match)
          game.game_winner_id
        else
          match = RPS.dbi.get_match_by_game_id(game.game_id)
          match.play(data['move'])
          game.turn = 'player1'
          RPS.dbi.update_match(match)
          match_winners_list = RPS.dbi.get_match_winners_by_game_id(game.game_id)
          game.check_winner(match_winners_list)
          RPS.dbi.update_game(game)
          game.game_winner_id
        end
      else
        redirect to "/"
      end
    end
  end

end