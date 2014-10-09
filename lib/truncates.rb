require "truncates/version"

module Truncates
  DEFAULT_MAX_LENGTH = 255
  
  def truncates(field_name, options = {})
    raise("Hash expected, got #{options.class.name}") if not options.is_a?(Hash) and not options.empty?
    max_length = options(:max_length) || DEFAULT_MAX_LENGTH
    
    before_validation do 
      value = eval("self.#{field_name}")
      
      if(value.present? && value.length > max_length)
        new_value = value.slice(0, max_length - 1)
        eval("self.#{field_name} = #{new_value}")
      end
    end
  end
end

ActiveRecord::Base.send(:extend, Truncates)