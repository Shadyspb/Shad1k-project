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

    def validation_presence(value, opt = nil)
      raise ArgumentError, 'Пустое значение или ранов Нулю' if send(value).to_s.empty?
    end

    def validation_format(value, format_value)
      raise ArgumentError, 'Неправильный формат' if send(value) !~ format_value
    end

    def validation_type(value, type)
      raise ArgumentError, 'Неправильный Тип' unless send(value).is_a?(type)
    end
  end
end
