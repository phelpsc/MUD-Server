require_relative 'model/CommandModel'
require_relative 'controller/Areas'
require_relative 'controller/Quit'
require_relative 'controller/Say'
require_relative 'controller/Tell'
require_relative 'controller/Who'

module Commands

  #TODO split command queues into SYNCHRONOUS and ASYNCHRONOUS
  #ASYNCHRONOUS command queue can happen in any order and in parallel
  #SYNCHRONOUS commands must be processed in the order they were sent

  class Command_Queue

    def initialize(users, mud_data)

      @command_model = CommandModel::Command_Model.new()

      @users = users
      @mud_data = mud_data

      #Commands we can invoke
      @areas = Areas::Areas.new(users, mud_data)
      @quit = Quit::Quit.new(users)
      @say = Say::Say.new(users)
      @tell = Tell::Tell.new(users)
      @who = Who::Who.new(users)

      #If not executing a command set to TRUE
      @waiting_for_command = true

      #Array of pending commands
      @pending = []

      #Current command being parsed and executed
      @current = ""

      #Most recent command executed
      @last = ""

      #Client that issued the current command
      @issuer = []
    end

    def push(user, command)
      @issuer.push(user)
      @pending.push(command)
      puts("New command pushed to queue")
      if (@waiting_for_command)
        @waiting_for_command = false
        execute()
      end
    end

    def execute()
      #todo check for server tick first
      @current = @pending[0]
      issuer = @issuer[0]

      #are we awaiting special input (e.g. login)
      if (!issuer.loggedin)
        puts "User issued command but is not logged in"
        issuer.login(@current)
        complete()
      else
        space_index = @current.index(" ")
        command_to_parse = (space_index == nil) ? @current : @current.slice(0, space_index)
        command_to_execute = @command_model.determine_command(command_to_parse)
        command_args = (space_index == nil) ? nil : @current.slice(space_index + 1, @current.length - space_index - 1)

        if (command_to_execute == "invalid")
          issuer.queue_message("Invalid command.")
          issuer.push_message_to_client()
          complete()
        else
          self.instance_variable_get("@"+command_to_execute).public_send("do", issuer, command_args, Proc.new{complete()})
        end
      end

    end

    def complete()
      #remove completed command from command queue array
      puts "Completing command."
      @last = @current
      @current = ""
      @pending.shift()
      @issuer.shift()
      #if command array is empty, set @waiting_for_command to TRUE
      #else execute next command
      if (@pending.length == 0)
        @waiting_for_command = true
      else
        execute()
      end
    end

  end

end
