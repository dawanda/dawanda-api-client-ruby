require File.dirname(__FILE__) + '/../../test_helper'

module Dawanda
  class ShopTest < Test::Unit::TestCase

    context "The Shop class" do

      should "be able to find a shop by :user_id" do
        user_id  = 5327518
        response = mock_request_cycle :for => "/shops/#{user_id}", :data => 'getShopDetails'
        
        Shop.expects(:new).with(response.result).returns('shop')
        #Shop.expects(:find_by_user_id).with(user_id, {}).returns('shop')

        Shop.find_by_user_id(user_id, {}).should == 'shop'
      end

    end

    context "An instance of the Shop class" do
      when_populating Shop,   :from => 'getShopDetails' do
        value_for :name,              :is => 'MEKO STORE'
        value_for :updated,           :is => "2009/09/29 09:58:46 +0000"
        value_for :created,           :is => "2007/05/18 10:44:17 +0000"
      end
      
      should "know the creation date" do
        shop = Shop.new
        shop.stubs(:created_at).with().returns(Time.at(1237430331.15))
        
        shop.created_at.should == Time.at(1237430331.15)
      end
      
      should "know the update date" do
        shop = Shop.new
        shop.stubs(:updated_at).with().returns(Time.at(1239717723.36))
        
        shop.updated_at.should == Time.at(1239717723.36)
      end
      
      should "have a collection of products" do
        user_id = '123'
        
        shop = Shop.new
        shop.expects(:user_id).with().returns(user_id)
        
        Product.expects(:find_all_by_shop_id).with(user_id, {}).returns('products')
        
        shop.products.should == 'products'
      end
      
      should "have an associated user" do
        user_id = 123
        
        shop = Shop.new
        shop.expects(:user_id).returns(user_id).at_least_once
        response = mock_request_cycle :for => "/users/#{shop.user_id}", :data => 'getUserDetails'
        
        User.expects(:new).with(response.result).returns('user')
        
        shop.user.should == 'user'
      end

    end

  end
end