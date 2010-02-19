require File.dirname(__FILE__) + '/../test_helper'

class DawandaTest < Test::Unit::TestCase

  context "The Dawanda module" do
    
    should "be able to set and retrieve the API key" do
      Dawanda.api_key = 'key'
      Dawanda.api_key.should == 'key'
    end
    
    should "be able to set and retrieve the country" do
      Dawanda.country = 'de'
      Dawanda.country.should == 'de'
    end
    
    should "be able to find a user by username" do
      user = stub()
      
      Dawanda::User.expects(:find_by_user_id).with('littletjane').returns(user)
      Dawanda.user('littletjane').should == user
    end
    
    should "be able to find a shop by username" do
      shop = stub()
      
      Dawanda::Shop.expects(:find_by_user_id).with('littletjane').returns(shop)
      Dawanda.shop('littletjane').should == shop
    end
    
    should "be able to find a product by id" do
      product = stub()
      
      Dawanda::Product.expects(:find_by_id).with(15).returns(product)
      Dawanda.product(15).should == product
    end
    
    should "be able to find a category by id" do
      category = stub()
      
      Dawanda::Category.expects(:find_by_id).with(16).returns(category)
      Dawanda.category(16).should == category
    end
    
    should "be able to find a shop category by id" do
      shop_category = stub()
      
      Dawanda::ShopCategory.expects(:find_by_id).with(16).returns(shop_category)
      Dawanda.shop_category(16).should == shop_category
    end
    
  end

end