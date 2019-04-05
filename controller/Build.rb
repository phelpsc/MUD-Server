module Build
  class Build

    def initialize(users)
      @users = users
    end

    def do(issuer, args, callback)

      #todo: check if issuer is proper type to toggle builder mode (i.e. Immortal)
      puts issuer.usertype

      if (issuer.usertype == "player")
        issuer.queue_message("Invalid command.")
      else
        issuer.buildmode = !issuer.buildmode
        if (issuer.buildmode)
          issuer.queue_message("World building mode enabled.")
        else
          issuer.queue_message("World building mode disabled.")
        end
      end

      issuer.push_message_to_client()
      callback.call()

    end

  end
end
