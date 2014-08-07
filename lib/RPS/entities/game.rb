module RPS

  class Game
    attr_reader :game_id, :player1_id, :player2_id, :game_winner_id

    def initialize(data)
      @player1_id = data['player1_id']
      @player1_name = data['player1_name']
      @game_id = nil
      @game_winner_id = nil
    end
    
    
    def determine_winner
    end



  end

end

# Game will have two player objects passed to it.
# Game will call match and keep track of wins and losses for each game.
# Game will declare a game winner.
# Game will call a method to write the game history to the database.
# Game will return the winner of the game.
