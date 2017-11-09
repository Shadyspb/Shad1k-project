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
      self.class.validation_store.each do |name, value|
        var_name = get_var(name)
        value.each do |validation_type, opt|
          send(validation_type, name, opt)
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

    def validate_presence(var_name, _opt = nil)
      raise ArgumentError, 'Пустое значение или пустая строка' if var_name.to_s.empty?
    end

    def validate_format(var_name, format_value)
      raise ArgumentError, 'Неправильный формат' if var_name !~ format_value
    end

    def validate_type(var_name, type)
      raise ArgumentError, 'Неправильный Тип' unless var_name.class.is_a?(type)
    end
  end
end
