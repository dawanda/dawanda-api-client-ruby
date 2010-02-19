module Dawanda
  
  # = Shop
  #
  # Represents a single Dawanda shop.  Users may or may not have an associated shop - 
  # check the result of User#seller? to find out.
  #
  # A shop has the following attributes:
  #
  # [name] The shop's name
  # [created_at] An announcement to buyers (displays on the shop's home page)
  # [updated_at] The message sent to users who buy from this shop
  # [banner_image_url] The full URL to the shops's banner image
  #
  class Shop
    
    include Dawanda::Model

    finder :one, '/shops/:user_id'
    finder :all, '/shops/:method'
    
    attribute :updated,           :from => :updated_at
    attribute :created,           :from => :created_at
    attribute :user_id,           :from => { :user => :id }
    attribute :banner_image_url,  :from => { :images => :banner }

    attributes :name
   
    # Time that this shop was created
    #
    def created_at
      Time.parse(created)
    end
    
    # Time that this shop was last updated
    #
    def updated_at
      Time.parse(updated)
    end
    
    # Search for shops with given keyword
    def self.search(keyword, params = {})
      params.update(:keyword => keyword)
      self.find_all_by_method('search', params)
    end
    
    def self.all(params = {})
      find_all_by_method('shops')
    end

    # A collection of products in this user's shop. See Dawanda::Product for
    # more information
    #
    def products(params = {})
      @products ||= Product.find_all_by_shop_id(user_id.to_s, params)
    end
    
    # The user who runs this shop. See Dawanda::User for more information
    def user(params = {})
      @user ||= User.find_by_user_id(user_id, params)
    end
    
    # All shop categories in this shop. See Dawanda::ShopCategory for more information
    def shop_categories(params = {})
      @shop_categories ||= ShopCategory.find_all_by_shop_id(user_id.to_s, params)
    end
  end
end