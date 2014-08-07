module RPS
  class SignUp
    def self.run(params)
      if params['username'].empty? || params['password'].empty? || params['password_conf'].empty?
        return {:success? => false, :error => "Blank fields"}
      elsif RPS.dbi.username_exists?(params['username'])
        return {:success? => false, :error => "User already exists."}
      elsif params['password'] != params['password_conf']
        return {:success? => false, :error => "Passwords do not match."}
      end

      user = RPS::User.new(params['username'])
      user.update_password(params['password'])
      RPS.dbi.persist_user(user)
      
      {
        :success? => true,
        :session_id => user.username
      }
    end
  end
end