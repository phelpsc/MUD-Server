module Say
  class Say

    def initialize(users)
      @users = users
    end

    def do(issuer, args, callback)

      issuer.queue_message("You say, '" + args + "'")
      issuer.push_message_to_client()

      @users.each do |user|
        if (user.name != issuer.name)
          user.queue_message("")
          user.queue_message(issuer.name + " says, '" + args + "'")
          user.push_message_to_client()
        end
      end

      callback.call()

    end

  end
end
