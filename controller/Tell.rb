module Tell
  class Tell

    def initialize(users)
      @users = users
    end

    def do(issuer, args, callback)

      space_index = args.index(" ")
      message_target = (space_index == nil) ? args : args.slice(0, space_index)
      message_target = message_target.slice(0,1).capitalize + message_target.slice(1..-1)
      message = (space_index == nil) ? nil : args.slice(space_index + 1, args.length - space_index - 1)

      #does target user exist and are they online?
      target_found = false

      @users.each do |user|
        if (user.name == message_target)
          target_found = true
          if (message == nil)
            issuer.client.send("What do you wish to tell " + message_target + "?")
          else
            issuer.client.send("You tell " + message_target + ", '" + message + "'")
            user.client.send("")
            user.client.send(issuer.name + " tells you, '" + message + "'")
          end
        end
      end

      if (!target_found)
        issuer.client.send("That person isn't online.")
      end

      callback.call()

    end
  end
end
