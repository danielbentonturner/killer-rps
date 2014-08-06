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



    def record_match(p1_move, p2_move, p1_result, p2_result)
      @db.exec_params(%q[
      INSERT INTO matches (
        player1_move, 
        player2_move,
        player1_result,
        player2_result)
        VALUES ($1, $2, $3, $4);
        ], [p1_move, p2_move, p1_result, p2_result])
    end

    def get_user_by_username(username)
      result = @db.exec_params(%q[
          SELECT * FROM users WHERE username = $1;
        ],[username])
    end
  end

  def self.dbi
    @__db_instance ||= DBI.new
  end
end
