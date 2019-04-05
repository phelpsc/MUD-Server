require 'rubame'
require 'mysql2'
require 'timers'
require_relative 'commands'
require_relative 'users'
require_relative 'dbconfig'
require_relative 'model/MudModel'

server = Rubame::Server.new("0.0.0.0", 9000)
users = []
mud_data = MudModel::MudModel.new()
queue = Commands::Command_Queue.new(users, mud_data)

dbconfig = DBConfig::DBConfig.new()

db = Mysql2::Client.new(
  :host => dbconfig.host,
  :username => dbconfig.user,
  :password => dbconfig.password,
  :database => dbconfig.database)

#TODO: Before we start the server running, load all server data into memory
#This includes: Areas, Rooms, Mobiles, Items, Help Files, Spells, Skills
mud_data.load(db)

#Server Game Loop
while true
  server.run do |client|
    client.onopen do
      user = Users::User.new(server, client, db)
      users.push(user)
    end
    client.onmessage do |message|
      users.each do |u|
        if (client == u.client)
          queue.push(u, "#{message}")
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
      puts "Server reports:  client closed"
    end
  end

  #TODO create timer that pushes server tick events to command queue
end
