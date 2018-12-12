module CommandModel

  class Command_Model

    INVALID = "invalid"
    QUIT = "quit"
    SAY = "say"
    TELL = "tell"
    WHO = "who"

    def initialize()
    end

    def determine_command(command)
      puts "Determining: " + command
      case command
      when "quit", "qui"
        return QUIT
      when "say", "sa"
        return SAY
      when "tell", "tel", "te", "t"
        return TELL
      when "who", "who"
        return WHO
      else
        return INVALID
      end
    end

  end

end
