module RPS

  class HandleGame

    def self.start_game(data)
      temp_game = Game.new(data)
      game = RPS.dbi.record_game(temp_game)
      params = {game:game}
      play_game(params) #-------figure out params
    end

    def self.play_game(data)
      if !game.game_winner_id
        match = Match.new()
        data[:game].determine_winner(match.result)
        return true
      end
        false
    end

  end

end