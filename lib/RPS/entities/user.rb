require 'digest/sha1'

module RPS
  class User
    attr_reader :username, :email, :last_login, :game_history, :created_at, :password_digest 
    #change :password_digest to more secure method

    def initialize(arg)
      @username = arg['username']
      @password_digest = arg['password_digest']||nil
      @email = arg['email']
      @last_login = Time.now();
      @game_histroy = arg['game_histroy']||[]
      @created_at = arg['created_at']||nil
    end

    def update_password(password)
      @password_digest = Digest::SHA1.hexdigest(password)
    end

    def valid_password?(password)
      Digest::SHA1.hexdigest(password) == @password_digest
    end

  end
end
