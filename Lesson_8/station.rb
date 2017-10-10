require './validate'

class Station
  attr_reader :trains, :name

  include Validate

  FORMAT_NAME = /^[а-я]{2,}$/i
  @@stations = []

  def self.all
    @@stations
  end

  def each_train
    @trains.each { |train| yield(train) }
  end

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@stations << self
  end

  def add_train(train)
    trains << train
  end

  def types_of_trains(type)
    trains.select { |train| train.type == type }
  end

  def delete_train(train)
    trains.delete(train)
  end

  def validate!
    raise 'Только буквы от А до Я и больше или равно 2 символам' if name !~ FORMAT_NAME
  end
end
