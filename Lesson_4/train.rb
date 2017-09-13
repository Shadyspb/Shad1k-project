class Train
  attr_reader :number, :type, :car_amount, :speed, :route, :station_index

  def initialize(number, type)
    @number = number
    @car_amount = []
    @speed = 0
    @type = type
  end

  def speed_increase(speed_delta)
  @speed = [@speed + speed_delta, 0].max
  end

  def stop
    @speed = 0
  end

  def attach_a_car(carriage)
    return "Вы не можете прицепить вагон пока поезд двигается" unless stopped?
      if self.type == carriage.type
        @car_amount << carriage
        puts "К поезду #{self.number} успешно прицеплен вагон типа #{self.type}"
      else puts "Вы можете прицепить вагон только одного типа с поездом"
      end
  end

  def unhook_a_car
    @car_amount.pop if stopped?
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

  def current_station
    station_at station_index
  end

  def next_station
    station_at station_index + 1
  end

  def previous_station
    station_at station_index - 1 if station_index > 0
  end

  private

  def stopped?
    speed == 0
  end
  
  def station_at(index)
     route.stations_list[index]
  end

end
