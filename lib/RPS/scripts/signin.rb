module RPS
  class SignIn
    def self.run(data)
      if data['username'].empty? || data['password'].empty?
        return {success?: false, error:"Blank fields"}
      end

      user = RPS.dbi.get_user_by_username(params['username'])
        return {success?: false, error: "No such user"} if user.nil?

      if !user.valid_password?(params['password'])
        return {succes?: false, error: "Password Invalid."}
      end

      {succes?: true, session_id: user.username}
    end
  end
end