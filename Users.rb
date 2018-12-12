module Users

  class User

    attr_accessor :server, :usertype, :name, :client, :db, :loggedin, :awaiting_special_input

    def initialize(server, client, db)
      @server = server
      @usertype = "player" #options [Player, Immortal, Builder]
      @name = ""
      @client = client
      @db = db
      @loggedin = false
      @client.send("Welcome to KitMud.")
      @client.send("By what name do you wish to be known?")
      @awaiting_special_input = true
    end

    def login(command)
      #Validate username
      if (command[/[a-zA-Z]+/] == command)
        #Query database for username
        results = @db.query("SELECT username, usertype FROM users WHERE username='#{command}' LIMIT 1")
        if results.count == 1
          results.each do |row|
            @name = row["username"]
            @usertype = row["usertype"]
          end
          @client.send("Welcome back, " + @name)
        else
          #Capitalize first letter of name
          capitalized_name = command.slice(0,1).capitalize + command.slice(1..-1)
          #Insert new playername into database
          results = @db.query("INSERT INTO users (username) VALUES ('#{capitalized_name}')")
          @name = capitalized_name
          @client.send("Creating new player. Welcome, " + @name)
        end
        @loggedin = true
        @client.send("Now entering the realm...")
      else
        @client.send("Your username may only contain letters.")
        @client.send("By what name do you wish to be known?")
      end
      #complete command
    end
  end
end
