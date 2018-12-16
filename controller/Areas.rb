module Areas
  class Areas

    def initialize(users, mud_data)
      @users = users
      @mud_data = mud_data
    end

    def do(issuer, args, callback)

      issuer.queue_message("Available Areas:")
      @mud_data.areas.each do |area|
        issuer.queue_message(area.name)
      end
      issuer.queue_message("")
      issuer.push_message_to_client();

      callback.call()

    end

  end
end
