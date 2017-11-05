module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(name, type, opt = nil)
      @validations ||= []
      @validations << { name: name, type: type, opt: opt }
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        send ("validation_#{validation[:type]}"), validation[:name], validation[:opt]
      end
    end

    def valid?
      validate!
      true
    rescue
      false
    end

    private

    def validate_presence(name, _opt = nil)
      raise ArgumentError, 'Пустое значение или пустая строка' if name.to_s.empty?
    end

    def validate_format(name, format_value)
      raise ArgumentError, 'Неправильный формат' if name !~ format_value
    end

    def validate_type(name, type)
      raise ArgumentError, 'Неправильный Тип' unless name.class.is_a?(type)
    end
  end
end
