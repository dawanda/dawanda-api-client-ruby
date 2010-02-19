module Dawanda
  
  # = Category
  #
  # Dawanda::Category are organized in a tree. To get the top level categories call top
  #
  # Represents a single Dawanda::Category - has the following attributes:
  #
  # [id] The unique identifier for this category
  # [parent_id] This category's parent id
  # [name] This category's name 
  # [product_count] The amount of products in this category
  #
  class Category
    
    include Dawanda::Model
    
    finder :all, '/categories/:name'
    finder :all, '/categories/:parent_id/children'
    finder :all, '/channels/:channel_id/categories'
    finder :one, '/categories/:id'
    
    attributes :id, :parent_id, :name, :product_count
    
    # Get all products for this category.
    def products(params = {})
      @products ||= Product.find_all_by_category_id(id, params)
    end
    
    # Get all the top level categories.
    def self.top(params = {})
      # This is a hack, because dynamic finder generation takes at least
      # one placeholder like ":name"
      self.find_all_by_name('top', params)
    end
    
    # Get all child categories of this category
    def children(params = {})
      Category.find_all_by_parent_id(id, params)
    end

    # Get the parent category of this category
    def parent(params = {})
      (parent_id and parent_id !=0) ? Category.find_by_id(parent_id, params) : nil
    end
  end
end