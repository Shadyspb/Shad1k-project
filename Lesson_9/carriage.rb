class Carriage
  attr_reader :type
  include Company

  def initialize(type)
    @type = type
  end
end
