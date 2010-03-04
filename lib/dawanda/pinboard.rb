module Dawanda
  
  # = Pinboard
  #
  # Represents a Pinboard - has the following attributes:
  #
  # [id] 
  # [name] 
  # [description] 
  #
  class Pinboard
    
    include Dawanda::Model
    
    finder :all, '/users/:user_id/pinboards'
    
    attributes :id, :name, :description
    
  end
end
