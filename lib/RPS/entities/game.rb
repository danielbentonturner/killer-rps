module RPS

  class Game
    attr_reader :game_id, :player1_id, :player2_id, :game_winner_id

    def initialize(data)
      @game_id = nil
      @player1_id = data['player1_id']
      @player2_id = data['player2_id']
      @game_winner_id = nil
    end
    

    def determine_winner
    end



  end

end
