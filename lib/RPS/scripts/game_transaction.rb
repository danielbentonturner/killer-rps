module RPS

  class InitGame

    def self.run(user_ids)
      temp_game = RPS::Game.new(user_ids)
      game = RPS.dbi.record_game(temp_game)
    end

  end

  class PlayGame

    def self.run(match_data)
      game = RPS.dbi.get_game_by_id(match_data['game_id'])
      if game.game_winner_id.nil?
        if game.turn == game.player1_id
          match = RPS::Match.new({'game_id' => game.game_id, 'player1_move' => match_data['move']})
          game.turn = game.player2_id
          RPS.dbi.update_game(game)
          RPS.dbi.record_match(match)
          game.game_winner_id
        else
          match = RPS.dbi.get_match_by_game_id(game.game_id)
          match.play(match_data['move'])
          game.turn = game.player1_id
          RPS.dbi.update_match(match)
          match_winners_list = RPS.dbi.get_match_winners_by_game_id(game.game_id)
          game.check_winner(match_winners_list)
          RPS.dbi.update_game(game)
          game.game_winner_id
        end
      end
    end
  end

end