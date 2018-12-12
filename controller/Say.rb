module Say
  class Say

    def initialize(users)
      @users = users
    end

    def do(issuer, args, callback)

      issuer.client.send("You say, '" + args + "'")

      @users.each do |user|
        if (user.name != issuer.name)
          user.client.send("")
          user.client.send(issuer.name + " says, '" + args + "'")
        end
      end

      callback.call()

    end

  end
end
