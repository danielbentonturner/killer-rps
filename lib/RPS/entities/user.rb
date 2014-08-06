require 'digest/sha1'

module RPS
  class User
    attr_reader :username, :email, :last_login, :game_history, :created_at

    def initialize(arg)
      @username = arg[:username]
      @password_digest = arg[:password_digest]||nil
      @email = arg[:email]
      @last_login = Time.now();
      @game_histroy = arg[:game_histroy]||[]
      @created_at = arg[:created_at]||nil
    end

    def update_password(password)
      @password_digest = Digest::SHA1.hexidigest(password)
    end

    def valid_password?(password)
      Digest::SHA1.hexidigest(password) == @password_digest
    end
  end
end
