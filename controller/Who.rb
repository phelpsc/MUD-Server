module Who
  class Who

    def initialize(users)
      @users = users
    end

    def do(issuer, args, callback)

      @users.each do |user|
        issuer.queue_message(user.name)
      end
      issuer.queue_message(@users.count.to_s + " users currently online.")      
      issuer.push_message_to_client()

      callback.call()

    end

  end
end
