require './route'
require './station'
require './train'
require './passenger_train'
require './cargo_train'
require './carriage'
require './carriage_cargo'
require './carriage_passenger'
require './company'
require './validate'

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
    puts "13 - Занять место в вагоне или Объем"
    puts "44 - Вывести на экран список вагонов у поезда"
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
      when 13 then take_place_or_capacity
      when 44 then carriage_show
      when 0 then abort
      menu
    end
  end

  private

  def create_station
    puts "Введите название станции:"
    name = gets.chomp.capitalize
    station = Station.new(name)
    @stations << station
    puts "Станция #{name}  создана"
    menu
  rescue => e
    puts e.message
    menu
  end

  def station_list
    puts "Станции пока не созданы" if stations.empty?
    stations.each { |station| puts station.name }
  end

  def create_train
    puts "Выберите какой поезд вы хотите создать?"
    puts "1 - пассажирский"
    puts "2 - грузовой"
    puts "0 - выход"
    input = gets.to_i

    case input
    when 1
      puts "Для создания пассажирского поезда, введите номер поезда "
      number = gets.chomp.to_i
      train = PassengerTrain.new(number)
      @trains << train
      puts "Поезд номер #{number} создан"
    when 2
      puts "Для создания грузового поезда, введите номер поезда"
      number = gets.chomp.to_i
      train = CargoTrain.new(number)
      @trains << train
      puts "Поезд номер #{number} создан"
    when 0
    end
    menu
  rescue => e
    puts e.message
    menu
  end

  def select_train
    number = gets.chomp.to_i
    @trains.find { |train| train.number == number }
  end

  def menu_car
    puts "Введите 1 если хотите добавить пассажирский вагон"
    puts "Введите 2 если хотите добавить грузовой вагон"
    input = gets.chomp.to_i
    case input
      when 1
        puts "Для создания пассажирского вагона введите номер вагона"
        num = gets.to_i
        puts "Для создания пассажирского вагона введите количество мест"
        place = gets.to_i
        @carriage = CarriagePassenger.new(num, place)
      when 2
        puts "Для создания грузового вагона введите номер вагона"
        num = gets.chomp
        puts "Для создания грузового вагона введите объем"
        capacity = gets.chomp
        @carriage = CarriageCargo.new(num, capacity)
      else puts "Ошибка повторите"
      menu
    end
  end

  def select_carriage
    train = select_train
    puts "Введите номер вагона"
    number = gets.to_i
    carriage = train.carriage[number - 1]
  end

  def take_place_or_capacity
    if carriage.class == CarriagePassenger
      carriage.take_place
      puts "Место успешно занято, свободных мест: #{@carriage.free_place}"
    elsif carriage.class == CarriageCargo
      puts "Введите занимаемый объем"
      capacity = gets.to_f
      carriage.load_capacity(capacity)
      puts "Объем успешно занят, #{@carriage.to_s}"
    end
    menu
  end

  def trains_list
    @stations.each do |station|
      puts "Station: '#{station.name}'"
      station.each_train { |train| puts "Номер поезда: #{train.number} Тип поезда: #{train.type} Кол-во вагонов: #{train.car_amount.length}" }
    end
  end

  def carriage_show
    puts "Введите номер поезда"
    train = select_train
    number = 0
    if train.class == PassengerTrain
      train.car_amount.each.with_index(1) do |carriage, carriage_number|
      puts "Номер вагона: #{carriage_number}, Тип вагона: #{train.type}, Свободных мест #{carriage.free_place}, Занятые Места #{carriage.take_place}"
      end
    elsif train.class == CargoTrain
      train.car_amount.each.with_index(1) do |carriage, carriage_number|
      puts "Номер вагона: #{carriage_number}, Тип вагона: #{train.type}, Cвободный объем: #{carriage.occupied_place}, Занятый обьем #{carriage.load_capacity}"
      end
    end
    menu
  end

  def attach_car
    menu_car
    puts "Введите номер поезда к которому хотите прицепить вагон:"
    train = select_train
    train.attach_a_car(carriage)
    menu
  end

  def unhook_сar
    puts "Введите номер поезд от которого хотите отцепить вагон:"
    train = select_train
    train.unhook_a_car
    puts "От поезда #{train.number} успешно отцеплен вагон типа #{train.type}"
    menu
  end

  def create_route
    station_list
    puts "Выберете начальную станцию маршрута:"
    input = gets.chomp.capitalize
    first_station = @stations.find { |station|  station.name == input }
    puts "Выберите конечную станцию маршрута:"
    input = gets.chomp.capitalize
    last_station = @stations.find { |station|  station.name == input }
    @route = Route.new(first_station, last_station)
    puts "Маршрут #{route.stations_list} создан"
    @routes << @route
    menu
  end

  def add_station_route
    station_list
    puts "Выберите название станции, которую хотите добавить"
    input = gets.chomp.capitalize
    station = @stations.find { |station|  station.name == input }
    @route.add_station(station)
    puts "Станция #{station} в маршрут #{route.stations_list} добавлена "
    menu
  end

  def delete_station_route
    station_list
    puts "Введите название станции, которую хотите удалить"
    input = gets.chomp.capitalize
    station = @stations.find { |station|  station.name == input }
    @route.delete_station(station)
    puts "Станция #{station} удалена из маршрута #{route.stations_list}"
    menu
  end

  def appoint_route
    puts "Введите номер поезда, к которому хотите присвоить маршрут"
    train = select_train
    train.set_route(route)
    puts "У поезда #{train.number} сейчас маршрут #{route.stations_list}"
    menu
  end

  def go
    puts "Введите номер поезда, который хотите отправить вперед"
    train = select_train
    train.forward_movement
    puts "Поезд #{train.number} прибыл на станцию #{train.current_station.name}"
    menu
  end

  def back
    puts "Введите номер поезда, который хотите отправить назад"
    train = select_train
    train.backward_movement
    puts "Поезд #{train.number} прибыл на станцию #{train.current_station.name}"
    menu
  end
end

run = Main.new
run.menu
