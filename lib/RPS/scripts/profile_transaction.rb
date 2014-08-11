module RPS

  class GameLookup

    def self.run(user_obj)
      game_list = RPS.dbi.get_game_by_user_id(user_obj.user_id)
      game_hash = Hash.new([])
      game_list.each do |x|
        if x.game_status == 'complete'
          game_hash['complete'] << x
        else game_hash['in_progress'] << x
        end
      end
        
      game_hash

    end


  end


end