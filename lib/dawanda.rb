$:.unshift File.dirname(__FILE__)

require 'net/http'
require 'json'
require 'time'

require 'dawanda/request'
require 'dawanda/response'

require 'dawanda/model'
require 'dawanda/user'
require 'dawanda/shop'
require 'dawanda/product'
require 'dawanda/category'
require 'dawanda/shop_category'
require 'dawanda/color'
require 'dawanda/channel'

# = DaWanda Client: A friendly Ruby interface to the DaWanda API
#
# == Quick Start
# 
# Getting started is easy.  First, you will need a valid API key from the Dawanda 
# developer site (http://dawanda.com/apps).  Since the API is read-only at
# the moment, that's all you need to do.
# 
# To start using the API, require the dawanda gem and set it up to use your API key:
# 
#     require 'rubygems'
#     require 'dawanda'
#     
#     Dawanda.api_key = 'itsasecret'
#     
# Now you can make API calls that originate from an Dawanda user:
# 
#     # Find a user by username
#     user = Dawanda.user('meko')
#     
#     # Grab that user's shop information
#     user.seller?
#     user.shop
#     user.shop.title
#     
#     # ... and the products in the shop
#     product = user.shop.products.first
#     product.title
#     product.description
#     
# To see what else is available for a user, check out the full documentation for
# the Dawanda::User class.
#
module Dawanda
 
  # Set the API key for all requests
  def self.api_key=(api_key)
    @api_key = api_key
  end
  
  # Retrieve the API key
  def self.api_key
    @api_key
  end
  
  # Set the country for all requests
  def self.country=(country)
    @country = country
  end
  
  # Retrieve the country
  def self.country
    @country || 'de'
  end
  
  # Find a user by username.  See Dawanda::User for more information.
  def self.user(username_or_id)
    User.find_by_user_id(username_or_id)
  end
  
  # Find a shop by username.  See Dawanda::Shop for more information.
  def self.shop(username_or_id)
    Shop.find_by_user_id(username_or_id)
  end
  
  # Find a product by id.  See Dawanda::Product for more information.
  def self.product(product_id)
    Product.find_by_id(product_id)
  end
  
  # Find a category by id.  See Dawanda::Category for more information.
  def self.category(category_id)
    Category.find_by_id(category_id)
  end
  
  # Find a shop_category by id.  See Dawanda::ShopCategory for more information.
  def self.shop_category(shop_category_id)
    ShopCategory.find_by_id(shop_category_id)
  end
  
end