class Station
  attr_reader :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    trains << train
  end

  def types_of_trains(type)
    trains.select {|train| train.type == type}
  end

  def delete_train(train)
    trains.delete(train)
  end
end

class Route
  attr_reader :stations_list

  def initialize(first_station, last_station)
    @stations_list = [first_station, last_station]
  end

  def add_station(station)
    stations_list.insert(-2,station)
  end

  def delete_station(station)
    stations_list.delete(station) if station != stations_list[0] && station != stations_list[last]
  end
end

class Train
  attr_reader :number, :type, :number_of_cars, :speed, :route, :station_index

  def initialize(number, type, number_of_cars)
    @number = number
    @type = type
    @car_amount = number_of_cars
    @speed = 0
  end

  def speed_increase(speed)
    self.speed += speed
    self.speed = 0 if speed < 0
  end

  def stop
    @speed = 0
  end

  def stopped
    speed == 0
  end

  def attach_a_car
    @car_amount += 1 if stopped
  end

  def unhook_a_car
    @car_amount -= 1 if stopped && number_of_cars > 0
  end

  def set_route(route)
    @route = route
    @station_index = 0
  end

  def forward_movement
    current_station.delete_train(self)
    @station_index += 1 if station_index < route.stations_list.size-1
    current_station.add_train(self)
  end

  def Backward_movement
    current_station.delete_train(self)
    @station_index -= 1 if station_index > 0
    current_station.add_train(self)
  end

  def show_station(index)
     route.stations_list[index]
  end

  def current_station
    show_station station_index
  end

  def next_station
    show_station station_index + 1
  end

  def previous_station
    show_station station_index - 1
  end
end
