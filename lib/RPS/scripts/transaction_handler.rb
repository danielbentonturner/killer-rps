module RPS

  class HandleGame

    def self.start_game(data)
      game = Game.new(data)

      game_id = RPS.dbi.record_game(game)
      record_game
    end

    def record_game(game)
    end



  class HandleMatch

    def self.start_match
      record_match
    end

    def record_match
      match_id = RPS.dbi.record_match(self)
    end
    end

  end

end