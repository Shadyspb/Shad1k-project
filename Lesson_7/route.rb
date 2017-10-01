class Route
  attr_reader :stations_list

  include Validate

  def initialize(first_station, last_station)
    @stations_list = [first_station, last_station]
    validate!
  end

  def add_station(station)
    stations_list.insert(-2,station)
  end

  def delete_station(station)
    stations_list.delete(station) if station != stations_list.first && station != stations_list.last
  end

  def validate!
    raise 'Первая и последня станция не может быть одинаковыми!' if @stations_list.first == @stations_list.last
  end
end
