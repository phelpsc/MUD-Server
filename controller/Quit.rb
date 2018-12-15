module Quit
  class Quit

    def initialize(users)
      @users = users
    end

    def do(issuer, args, callback)

      @users.each do |user|
        if (user.name == issuer.name)
          user.queue_message("")
          user.queue_message("Alas, all good things must come to an end.")
          user.push_message_to_client()
          user.server.close(user.client)
        end
      end

      callback.call()

    end

  end
end
