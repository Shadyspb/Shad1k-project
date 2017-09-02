class Train
  attr_reader :number, :type, :number_of_cars, :speed, :route, :station_index

  def initialize(number)
    @number = number
    @car_amount = []
    @speed = 0
  end

  def self.create_passenger(number)
    Passenger.new(number)
  end

  def self.create_cargo(number)
    Cargo.new(number)
  end

  def speed_increase(speed_delta)
  @speed = [@speed + speed_delta, 0].max
  end

  def stop
    @speed = 0
  end

  def stopped
    speed == 0
  end

  def attach_a_car(car)
    @car_amount << car if stopped
  end

  def unhook_a_car
    @car_amount.pop if stopped
  end

  def set_route(route)
    @route = route
    @station_index = 0
    current_station.add_train(self)
  end

  def forward_movement
    #return if stopped
    current_station.delete_train(self)
    @station_index += 1 if station_index < route.stations_list.size-1
    current_station.add_train(self)
  end

  def backward_movement
    #return if stopped
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
    show_station station_index - 1 if station_index > 0
  end
end
