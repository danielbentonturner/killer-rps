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
        name varchar(30),
        password_digest text,
        email text,
        last_login timestamp,
        game_history integer[],
        created_at timestamp NOT NULL DEFAULT current_timestamp
      )])


      @db.exec_params(%q[
      CREATE TABLE IF NOT EXISTS games(
        id serial NOT NULL PRIMARY KEY,
        player1_id integer REFERENCES users(id),
        player2_id integer REFERENCES users(id),
        game_winner_id integer REFERENCES users(id),
        match_list integer[],
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

    def record_match(match)
      result = @db.exec_params(%q[
      INSERT INTO matches (
        player1_move, 
        player2_move,
        player1_result,
        player2_result)
        VALUES ($1, $2, $3, $4);
        RETURNING id,
        ], [match.player1_move, match.player2_move, match.player1_result, match.player2_result])

        id = result.first['id'].to_i
    end

    def init_game
    end

    def record_user(user)
      @db.exec_params(%q[
      INSERT INTO users (
        name,
        password_digest,
        email,
        last_login)
        VALUES ($1, $2, $3, $4);
        ], [user.username, user.password_digest, user.email, user.last_login])
    end

    def username_exists?(username)
      result = @db.exec_params(%q[
          SELECT * FROM users WHERE name = $1;
        ],[username])
      if result.count > 1
        true
      else
        false
      end
    end

    def get_user_by_username(username)
      result = @db.exec_params(%q[
          SELECT * FROM users WHERE name = $1;
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
