module Who
  class Who

    def initialize(users)
      @users = users
    end

    def do(issuer, args, callback)

      @users.each do |user|
        issuer.client.send(user.name)
      end
      issuer.client.send(@users.count.to_s + " users currently online.")

      callback.call()

    end

  end
end
