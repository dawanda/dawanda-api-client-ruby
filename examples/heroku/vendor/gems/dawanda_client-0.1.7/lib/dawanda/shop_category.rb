module Dawanda
  
  # = ShopCategory
  #
  # Represents a single Dawanda::ShopCategory - has the following attributes:
  #
  # [id] The unique identifier for this shop category
  # [name] This shop category's name 
  # [product_count] The amount of products in this shop category
  # [restful_path] The path to the shop category
  #
  class ShopCategory
    
    include Dawanda::Model
    
    finder :all, '/shops/:shop_id/shop_categories'
    finder :one, '/shop_categories/:id'
    
    attributes :id, :name, :position, :restful_path, :product_count
    
    
    # All products in this shop category. See Dawanda::Product for more information
    def products(params = {})
      Product.find_all_by_shop_category_id(id, params)
    end
    
  end
end