module CommandModel

  class Command_Model

    AREAS = "areas"
    BUILD = "build"
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
      when "areas", "area"
        return AREAS
      when "build"
        return BUILD
      when "quit", "qui"
        return QUIT
      when "say", "sa"
        return SAY
      when "tell", "tel", "te", "t"
        return TELL
      when "who", "wh"
        return WHO
      else
        return INVALID
      end
    end

  end

end
