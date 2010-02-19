module Dawanda
  
  # = User
  #
  # Represents a single Dawanda user - has the following attributes:
  #
  # [id] The unique identifier for this user
  # [name] This user's username
  # [city] The user's city / state (optional)
  # [sex] The user's gender
  # [transaction_sold_count] How many products have been sold by this user
  # [is_seller] Is this user a seller?
  # [bio] User's biography
  # [restful_path]
  # [url] The full URL to this user's profile page / shop (if seller)
  #
  class User
    
    include Dawanda::Model
    
    finder :one, '/users/:user_id'
    finder :all, '/users/:method'
    
    # attribute :last_login, :from => :last_login_epoch

    attributes :id, :name, :url, :city, :sex, :bio, :transaction_sold_count, :is_seller, :images
    
    # This user's shop, returns nil if user is not a seller. See Dawanda::Shop
    # for more information.
    #
    def shop(params = {})
      @shop ||= Shop.find_by_user_id(id, params) if seller?
    end

    # Search for users with given keyword
    def self.search(keyword, params = {})
      params.update(:keyword => keyword)
      self.find_all_by_method('search', params)
    end
    
    # Is this user a seller?
    #
    def seller?
      is_seller
    end
    
    def image_40x40
      images.first['image_40x40']
    end
    
    def image_80x80
      images.first['image_80x80']
    end
    
    def image_170x
      images.first['image_170x']
    end
    
  end
end