require "truncates/version"

module Truncates
  DEFAULT_MAX_LENGTH = 255
  DEFAULT_CHARACTER_TRAIL = ""
  DEFAULT_ON = :validation
  
  def truncates(field_name, options = {})
    raise("Hash expected, got #{options.class.name}") if !options.is_a?(Hash) && !options.empty?
    max_length = options[:max_length] || DEFAULT_MAX_LENGTH
    character_trail = options[:character_trail] || DEFAULT_CHARACTER_TRAIL    
    on = options[:on] || DEFAULT_ON
      puts "field_name: #{field_name}\non: #{on}"
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
      define_method "#{field_name}=" do |value|
        new_value = value
        if(value.present? && value.length > max_length)
          new_value = value.slice(0, max_length - character_trail.length) + character_trail
        end
        
        super(new_value)
        #eval("@#{field_name} = \"#{new_value}\"")
        #eval("return @#{field_name}")
      end  
    end
  end
end

ActiveRecord::Base.send(:extend, Truncates)