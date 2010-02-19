require File.dirname(__FILE__) + '/../../test_helper'

module Dawanda
  class UserTest < Test::Unit::TestCase

    context "The User class" do

      should "be able to find a user by :user_id" do
        user_id  = 5327518
        response = mock_request_cycle :for => "/users/#{user_id}", :data => 'getUserDetails'
        User.expects(:new).with(response.result).returns('user')

        User.find_by_user_id(user_id, {}).should == 'user'
      end
    end
    
    context "An instance of the User class" do
      when_populating User,   :from => 'getUserDetails' do
        value_for :name,                    :is => 'meko'
        value_for :transaction_sold_count,  :is => 4854           
        value_for :is_seller,               :is => true
        value_for :city,                    :is => "auma"
        value_for :sex,                     :is => 'female'
      end
            
      should "have an associated shop if user is seller" do
        user_id = 123
        user = User.new
        user.expects(:id).returns(user_id).at_least_once
        user.expects(:seller?).returns(true)
        response = mock_request_cycle :for => "/shops/#{user.id}", :data => 'getShopDetails'
        Shop.expects(:new).with(response.result).returns('shop')
        
        user.shop.should == 'shop'
      end
    end
  end
end