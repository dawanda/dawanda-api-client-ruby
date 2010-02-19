module Dawanda
  
  # = Color
  #
  # Represents a single Color - has the following attributes:
  #
  # [hex] This color's hex value
  # [red] The color's red value from 0-255
  # [green] The color's green value from 0-255
  # [blue] The color's blue value from 0-255
  #
  class Color
    
    include Dawanda::Model
    
    attributes :hex, :red, :green, :blue
    
    def products(params = {})
      Product.find_all_by_hex(hex, params)
    end
    
  end
end
