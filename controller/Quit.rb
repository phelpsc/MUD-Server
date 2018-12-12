module Quit
  class Quit

    def initialize(users)
      @users = users
    end

    def do(issuer, args, callback)

      @users.each do |user|
        if (user.name == issuer.name)
          user.client.send("")
          user.client.send("Alas, all good things must come to an end.")
          user.server.close(user.client)
        end
      end

      callback.call()

    end

  end
end
