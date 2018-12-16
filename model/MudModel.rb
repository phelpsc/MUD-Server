require_relative 'AreaModel'

module MudModel

  class MudModel

    attr_accessor :areas, :rooms, :objects, :mobiles

    def initialize()
      @areas = []
      @rooms = []
      @objects = []
      @mobiles = []
      @db = nil
    end

    def load(db)
      @db = db
      area_results = @db.query("SELECT * FROM areas")
      area_results.each do |area_row|
        area = AreaModel::AreaModel.new()
        area.load(area_row)
        @areas.push(area)
      end
    end
  end
end
