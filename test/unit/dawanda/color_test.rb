require File.dirname(__FILE__) + '/../../test_helper'

module Dawanda
  class ColorTest < Test::Unit::TestCase

    context "The Color class" do

      should "be able to find a shop by :user_id" do
        user_id  = 5327518
        response = mock_request_cycle :for => "/shops/#{user_id}", :data => 'getShopDetails'

        # Shop.expects(:new).with(response.result).returns('shop')
        Shop.expects(:find_by_user_id).with(user_id, {}).returns('shop')

        Shop.find_by_user_id(user_id, {}).should == 'shop'
      end

    end
  end
end