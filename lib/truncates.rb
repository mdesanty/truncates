require "truncates/version"

module Truncates
  DEFAULT_MAX_LENGTH = 255
  DEFAULT_CHARACTER_TRAIL = ""
  DEFAULT_ON = :before_validation
  
  def truncates(field_name, options = {})
    raise("Hash expected, got #{options.class.name}") if !options.is_a?(Hash) && !options.empty?
    max_length = options[:max_length] || DEFAULT_MAX_LENGTH
    character_trail = options[:character_trail] || DEFAULT_CHARACTER_TRAIL    
    on = options[:on] || DEFAULT_ON
        
    case on.to_s
    when "validation"
      before_validation do       
        value = eval("self.#{field_name}")      
        
        if(value.present? && value.length > max_length)
          new_value = value.slice(0, max_length - character_trail.length) + character_trail        
          eval("self.#{field_name}=\"#{new_value}\"")
        end
      end
    when "set"
      method = 
      "def #{field_name}=(value)" +
      "  if(value.present? && value.length > max_length)" +
      "    new_value = value.slice(0, max_length - character_trail.length) + character_trail" +                  
      "  end" +
      "  \n" +
      "  super(new_value)" +
      "end"
            
      eval(method.to_s)
    end
  end
end

ActiveRecord::Base.send(:extend, Truncates)
ActiveModel::Validations.send(:extend, Truncates)
