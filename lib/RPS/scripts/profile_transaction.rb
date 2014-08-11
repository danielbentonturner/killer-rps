module RPS

  class GameLookup

    def self.run(user_obj)
      game_list = RPS.dbi.get_game_by_user_id(user_obj.user_id)
      game_hash = {
        'complete' => [],
        'in_progress' => []
      }
      game_list.each do |x|
        if x.game_status == 'complete'
          game_hash['complete'].push(x)
        else 
          game_hash['in_progress'].push(x)
        end
      end
        
      game_hash
    end
  end

  class MatchLookup
    def self.run(game_hash)
      match_hash = Hash.new {|key,value| match_hash[key]||=[]}
      game_hash['in_progress'].each do |game|
        last_match = RPS.dbi.get_match_by_game_id(game.game_id)
        match_hash[game.game_id]=last_match
      end
      match_hash
    end
  end


end