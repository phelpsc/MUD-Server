module Users

  class User

    attr_accessor :server, :usertype, :name, :client, :db, :loggedin, :awaiting_special_input, :buildmode

    def initialize(server, client, db)
      @server = server
      @usertype = "player" #options [Player, Immortal, Builder]
      @name = ""
      @client = client
      @db = db
      @message_array = []
      @loggedin = false
      @awaiting_special_input = true
      @buildmode = false

      self.queue_message("Welcome to KitMud.")
      self.queue_message("By what name do you wish to be known?")
      self.push_message_to_client()
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
          self.queue_message("Welcome back, " + @name)
          self.push_message_to_client()
        else
          #Capitalize first letter of name
          capitalized_name = command.slice(0,1).capitalize + command.slice(1..-1)
          #Insert new playername into database
          results = @db.query("INSERT INTO users (username) VALUES ('#{capitalized_name}')")
          @name = capitalized_name
          self.queue_message("Creating new player. Welcome, " + @name)
          self.push_message_to_client()
        end
        @loggedin = true
        self.queue_message("Now entering the realm...")
        self.push_message_to_client()
      else
        self.queue_message("Your username may only contain letters.")
        self.queue_message("By what name do you wish to be known?")
        self.push_message_to_client()
      end
      #complete command
    end

    def queue_message(msg)
      @message_array.push(msg)
    end

    def push_message_to_client()
      @client.send(["message", @message_array, "TODO::PROMPT_TEXT"])
      self.flush()
    end

    def flush()
      @message_array = []
    end

  end
end
