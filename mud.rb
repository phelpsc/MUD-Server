require 'rubame'
require 'mysql2'
require 'timers'
require_relative 'commands'
require_relative 'users'
require_relative 'dbconfig'

server = Rubame::Server.new("0.0.0.0", 9000)
users = []
queue = Commands::Command_Queue.new(users)

dbconfig = DBConfig::DBConfig.new()

db = Mysql2::Client.new(
  :host => dbconfig.host,
  :username => dbconfig.user,
  :password => dbconfig.password,
  :database => dbconfig.database)

while true
  server.run do |client|
    client.onopen do
      user = Users::User.new(server, client, db)
      users.push(user)
    end
    client.onmessage do |mess|
      users.each do |u|
        if (client == u.client)
          queue.push(u, "#{mess}")
        end
      end
    end
    client.onclose do
      i = 0
      users.each do |u|
        if (u.client.closed)
          users.delete_at(i)
        else
          i += 1
        end
      end
      #@client.send("Alas, all good things must come to an end.")
      puts "Server reports:  client closed"
    end
  end

  #TODO create timer that pushes server tick events to command queue
end
