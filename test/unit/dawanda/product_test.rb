require File.dirname(__FILE__) + '/../../test_helper'

module Dawanda
  class ProductTest < Test::Unit::TestCase

    context "The Product class" do

      should "be able to find a shop by :user_id" do
        product_id  = 5327518
        response = mock_request_cycle :for => "/products/#{product_id}", :data => 'getProductDetails'

        Product.expects(:new).with(response.result).returns('product')

        Product.find_by_id(product_id, {}).should == 'product'
      end

    end
    
    context "An instance of the Product class" do
      when_populating Product,   :from => 'getProductDetails' do
        value_for :name,              :is => 'Hoodie "SUE"'
        value_for :product_url,       :is => 'http://de.dawanda.com/product/4316882-Hoodie-SUE'
        value_for :tags,              :is => "pullover, carina, meko, Sweat, Hoodie, Karo, shabby chic"
        value_for :quantity,          :is => 1
        value_for :materials,         :is => "Baumwollmischgewebe"
        value_for :view_count,        :is => 3769
        value_for :ending,            :is => "2010/01/27 11:12:39 +0000"
      end
      
      should "have an associated shop" do
        user_id  = 5327518
        
        product = Product.new
        product.expects(:user_id).returns(user_id).at_least_once
        response = mock_request_cycle :for => "/shops/#{user_id}", :data => 'getShopDetails'
        
        Shop.expects(:new).with(response.result).returns('shop')
        
        product.shop.should == 'shop'
      end
      
      should "have an associated category" do
        category_id  = 5327518
        
        product = Product.new
        product.expects(:category_id).returns(category_id).at_least_once
        response = mock_request_cycle :for => "/categories/#{category_id}", :data => 'getCategoryDetails'
        
        Category.expects(:new).with(response.result).returns('category')
        
        product.category.should == 'category'
      end
    end
  end
end