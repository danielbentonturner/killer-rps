require 'digest/sha1'

module RPS
  class User
    attr_reader :user_id, :username, :email, :last_login, :created_at, :password_digest 
    #change :password_digest to more secure method

    def initialize(arg)
      @user_id = arg['id']
      @username = arg['username']
      @password_digest = arg['password_digest']||nil
      @email = arg['email']
      @last_login = Time.now();
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
