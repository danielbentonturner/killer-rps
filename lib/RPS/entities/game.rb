module RPS

  class Game
    attr_reader :game_id, :player1_id, :player2_id, :game_winner_id, :game_status
    attr_accessor :turn

    def initialize(data)
      @game_id = nil
      @player1_id = data['player1_id']
      @player2_id = data['player2_id']
      @game_winner_id = nil
      @game_status = nil
      @turn = :player1
    end
    

    def check_winner?
    end



  end

end
