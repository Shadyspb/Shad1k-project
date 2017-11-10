module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(name, validation_type, opt = 0)
      @validations ||= {}
      @validations[name] ||= {}
      @validations[name].merge!(validation_type => opt)
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |name, value|
        attr = send(name)
        value.each do |validation_type, opt|
          send(validation_type, attr, opt)
        end
      end
    end

    def valid?
      validate!
      true
    rescue
      false
    end

    private

    def validate_presence(attr, _opt = nil)
      raise ArgumentError, 'Пустое значение или пустая строка' if  attr.to_s.empty?
    end

    def validate_format(attr, format_value)
      raise ArgumentError, 'Неправильный формат' if  attr !~ format_value
    end

    def validate_type(attr, type)
      raise ArgumentError, 'Неправильный Тип' unless  attr.class.is_a?(type)
    end
  end
end
