require 'pg'

module RPS
  class DBI
   
    # this initialize method is only ever run once. make sure you
    # update your `dbname`. here it is petbreeder.
    def initialize
      @db = PG.connect(host: 'localhost', dbname: 'killer_rps')
      build_tables
    end
    
    # these methods create the tables in your db if they
    # dont already exist
    def build_tables

      @db.exec_params(%q[
      CREATE TABLE IF NOT EXISTS users(
        id serial NOT NULL PRIMARY KEY,
        username varchar(30),
        password_digest text,
        email text,
        last_login timestamp,
        created_at timestamp NOT NULL DEFAULT current_timestamp
      )])


      @db.exec_params(%q[
      CREATE TABLE IF NOT EXISTS games(
        id serial NOT NULL PRIMARY KEY,
        player1_id integer REFERENCES users(id),
        player2_id integer REFERENCES users(id),
        game_winner_id integer REFERENCES users(id),
        created_at timestamp NOT NULL DEFAULT current_timestamp
      )])


      @db.exec_params(%q[
      CREATE TABLE IF NOT EXISTS matches(
        id serial NOT NULL PRIMARY KEY,
        player1_move varchar(9),
        player2_move varchar(9),
        player1_result varchar(5),
        player2_result varchar(5),
        created_at timestamp NOT NULL DEFAULT current_timestamp
      )])
    end


    def build_user(data)
      user = RPS::User.new(data)
    end

    def build_game(data)
      game = RPS::Game.new(data)
    end

    def build_match(data)
      match = RPS::Match.new(data)
    end

    def record_match(match)
      result = @db.exec_params(%q[
      INSERT INTO matches (
        player1_move, 
        player2_move,
        player1_result,
        player2_result)
        VALUES ($1, $2, $3, $4)
        RETURNING id;
        ], [match.player1_move, match.player2_move, match.player1_result, match.player2_result])

        match.instance_variable_set(:match_id, result.first['id'].to_i)
        match
    end

    def record_game(game)
      result = @db.exec_params(%q[
      INSERT INTO games(
        player1_id, 
        player2_id,
        game_winner_id)
        VALUES ($1, $2, $3)
        RETURNING id;
        ], [game.player1_id, game.player2_id, game.game_winner_id])

        game.instance_variable_set(:@game_id, result.first['id'].to_i)
        game

    end

    def init_game
      result = @db.exec_params(%q[]
        )
    end

    def record_user(user)
      result = @db.exec_params(%q[
      INSERT INTO users (
        username,
        password_digest,
        email,
        last_login)
        VALUES ($1, $2, $3, $4);
        ], [user.username, user.password_digest, user.email, user.last_login])

    end

    def username_exists?(username)
      result = @db.exec_params(%q[
          SELECT * FROM users WHERE username = $1;
        ],[username])
      if result.count > 1
        true
      else
        false
      end
    end

    def get_match_by_id(match_id)
      result = @db.exec_params(%q[
      SELECT * FROM match WHERE match_id = $1;
      ],[match_id])
      match_data = result.first

      if match_data
        build_match(match_data)
      else
        nil
      end
    end

    def get_game_by_id(game_id)
      result = @db.exec_params(%q[
      SELECT * FROM game WHERE game_id = $1;
      ],[game_id])
      game_data = result.first

      if game_data
        build_game(game_data)
      else
        nil
      end
    end

    def get_user_by_username(username)
      result = @db.exec_params(%q[
          SELECT * FROM users WHERE username = $1;
        ],[username])
        user_data = result.first

      if user_data
        build_user(user_data)
      else
        nil
      end
    end


  end

  def self.dbi
    @__db_instance ||= DBI.new
  end
end
