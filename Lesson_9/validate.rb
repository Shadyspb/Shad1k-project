module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(name, type, _opt = nil)
      @validations ||= []
      @validations << { name: name, type: type, opt: _opt }
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
      raise ArgumentError, 'Пустое значение или пустая строка' if send(name.to_s).to_s.empty?
    end

    def validation_format(name, format_value)
      raise ArgumentError, 'Неправильный формат' if send(name) !~ format_value
    end

    def validation_type(name, type)
      raise ArgumentError, 'Неправильный Тип' unless send(name).is_a?(type)
    end
  end
end
