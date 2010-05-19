module Dawanda
  
  # = Pinboard
  #
  # Represents a Pinboard - has the following attributes:
  #
  # [id] The unique identifier for this pinboard
  # [name] The pinboard's name
  # [description] Pinboard's description
  #
  class Pinboard
    
    include Dawanda::Model
    
    finder :one, '/pinboards/:id'
    finder :all, '/users/:user_id/pinboards'
    
    attributes :id, :name, :description, :user
    
    def products(params = {})
      Product.find_all_by_pinboard_id(id, params)
    end
    
  end
end
