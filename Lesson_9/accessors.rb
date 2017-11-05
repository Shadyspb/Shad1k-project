module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}"
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=") do |value|
        instance_variable_set(var_name, value)
        @history ||= {}
        @history[var_name] ||= []
        @history[var_name] << value
      end
      define_method("#{name}_history") { @history[var_name] unless @history.nil? }
    end
end

def strong_attr_accessor(name, class_name)
   var_name = "@#{name}"
   define_method(name) { instance_variable_get(var_name) }
   define_method("#{name}=") do |value|
     raise 'Не верный класс' unless value.is_a?(class_name)
     instance_variable_set(var_name, value)
   end
 end
end
