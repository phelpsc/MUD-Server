module AreaModel
  class AreaModel
    attr_accessor :name, :builders, :repop_message, :repop_time, :weather, :is_open_to_mortals

    def initialize()
    end

    def load(data)
      @name = data["areaname"]
      @builders = data["builders"]
      @repop_message = data["repop_message"]
      @repop_time = data["repop_time"]
      @weather = data["weather"]
      @is_open_to_mortals = data["is_open_to_mortals"]
      puts "Loading area: " + @name
    end

  end
end
