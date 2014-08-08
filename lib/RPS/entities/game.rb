module RPS

  class Game
    attr_reader :game_id, :player1_id, :player2_id, :game_winner_id, :game_status, :tempname
    attr_accessor :turn

    def initialize(data)
      @game_id = nil || data['id']
      @player1_id = data['player1_id']
      @player2_id = data['player2_id']
      @game_winner_id = data['game_winner_id'] ||  nil
      @game_status = data['game_status'] ||  nil
      @turn = data['turn'] || 'player1'
      @tempname = Hash.new[0]
    end
    

    def check_winner(result)
      if result != :draw
        @tempname[result]+=1
        @tempname.each do |player,score| 
          if score >=3 
            if player == :player1
              @game_winner_id = @player1_id
            else
              @game_winner_id = @player2_id
            end
          end
        end
      end
    end

  end
end
