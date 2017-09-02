require './route'
require './station'
require './train'
require './passenger'
require './cargo'
require './car'
require './car_cargo'
require './car_passenger'

class Main
attr_accessor :station, :trains, :train, :route, :stations,
              :number, :name, :carriage

  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def menu
    puts "1 - Создать станцию."
    puts "2 - Просмотреть список станций"
    puts "3 - Просмотреть список поездов на станции"
    puts "4 - Создать поезд"
    puts "5 - Прицепить вагон к поезду"
    puts "6 - Отцепить вагон от поезда"
    puts "7 - Создать маршрут"
    puts "8 - Добавить станцию в маршрут"
    puts "9 - Удалить станцию из маршрута"
    puts "10 - Назначить маршрут поезду"
    puts "11 - Переместить поезд по маршруту вперед"
    puts "12 - Переместить поезд по маршруту назад"
    puts "0 - Выход"
    input = gets.chomp.to_i

    case input
      when 1 then create_station
      when 2 then station_list
      when 3 then trains_list
      when 4 then create_train
      when 5 then attach_car
      when 6 then unhook_сar
      when 7 then create_route
      when 8 then add_station_route
      when 9 then delete_station_route
      when 10 then appoint_route
      when 11 then go
      when 12 then back
      when 00 then abort
      menu
    end
  end

  private

  def create_station
    puts "Введите название станции:"
    name = gets.chomp.capitalize
    @station = Station.new(name)
    @stations << station
    puts "Станция #{name}  создана"
    menu
  end

  def station_list
    stations.each { |station| puts station.name } || "Станций пока не существует"
  end

  def trains_list
    station_list
    puts "Выберите станцию:"
    input = gets.chomp.capitalize
    index = @stations.find_index { |station|  station.name == input }
    current_station = @stations[index]
    puts "На станции #{current_station.name} сейчас #{current_station.trains.size} поездов"
    menu
  end

  def create_train
    puts "Выберите какой поезд вы хотите создать?"
    puts "1 - пассажирский"
    puts "2 - грузовой"
    puts "0 - выход"
    input = gets.chomp.to_i

    case input
    when 1
      puts "Для создания пассажирского поезда, введите номер поезда "
      number = gets.chomp.to_i
      @train = Passenger.new(number)
      @trains << train
      puts "Поезд номер #{number} создан"
      menu
    when 2
      puts "Для создания грузового поезда, введите номер поезда"
      number = gets.chomp.to_i
      @train = Cargo.new(number)
      @trains << train
      puts "Поезд номер #{number} создан"
      menu
    when 0
      menu
    else puts "Ошибка, не правильно ввели номер"
    menu
    end
  end

  def selected_train
    number = gets.chomp.to_i
    index = @trains.find_index { |train| train.number == number }
    index.nil? ? menu : @train = @trains[index]
  end

  def attach_car
    menu_car
    puts "Введите номер поезда к которому хотите прицепить вагон:"
    selected_train.attach_a_car(carriage)
    puts "К поезду #{@train.number} успешно прицеплен вагон типа #{@carriage.type}"
    menu
  end

  def menu_car
    puts "Введите 1 если хотите добавить пассажирский вагон"
    puts "Введите 2 если хотите добавить грузовой вагон"
    input = gets.chomp.to_i

    case input
    when 1 then @carriage = CarriagePassenger.new
    when 2 then @carriage = CarriageCargo.new
    else puts "Ошибка повторите"
    menu
    end
  end

  def unhook_сar
    puts "Введите номер поезд от которого хотите отцепить вагон:"
    selected_train.unhook_a_car
    puts "От поезда #{@train.number} успешно отцеплен вагон типа #{@carriage.type}"
    menu
  end

  def create_route
    station_list
    puts "Выберете начальную станцию маршрута:"
    input = gets.chomp.capitalize
    index = @stations.find_index { |station|  station.name == input }
    first_station = @stations[index]
    puts "Выберите конечную станцию маршрута:"
    input = gets.chomp.capitalize
    index = @stations.find_index { |station|  station.name == input }
    last_station = @stations[index]
    @route = Route.new(first_station, last_station)
    puts "Маршрут #{route.stations_list} создан"
    @routes << @route
    menu
  end

  def add_station_route
    station_list
    puts "Выберите название станции, которую хотите добавить"
    input = gets.chomp.capitalize
    index = @stations.find_index { |station|  station.name == input }
    station = @stations[index]
    @route.add_station(station)
    puts "Станция #{station} в маршрут #{route.stations_list} добавлена "
    menu
  end

  def delete_station_route
    station_list
    puts "Введите название станции, которую хотите удалить"
    input = gets.chomp.capitalize
    index = @stations.find_index { |station|  station.name == input }
    station = @stations[index]
    @route.delete_station(station)
    puts "Станция #{@station} удалена из маршрута #{route.stations_list}"
    menu
  end

  def appoint_route
    puts "Введите номер поезда, к которому хотите присвоить маршрут"
    selected_train.set_route(route)
    puts "У поезда #{train.number} сейчас маршрут #{route.stations_list}"
    menu
  end

  def go
    puts "Введите номер поезда, который хотите отправить вперед"
    selected_train.forward_movement
    puts "Поезд #{train.number} прибыл на станцию #{@train.current_station.name}"
    menu
  end

  def back
    puts "Введите номер поезда, который хотите отправить назад"
    selected_train.backward_movement
    puts "Поезд #{train.number} прибыл на станцию #{@train.current_station.name}"
    menu
  end
end

run = Main.new
run.menu
