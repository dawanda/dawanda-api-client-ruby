require File.dirname(__FILE__) + '/../../test_helper'

module Dawanda
  class CategoryTest < Test::Unit::TestCase

    context "The Category class" do

      should "be able to find a category by :id" do
        id  = 5327518
        response = mock_request_cycle :for => "/categories/#{id}", :data => 'getCategoryDetails'

        Category.expects(:new).with(response.result).returns('category')
        
        Category.find_by_id(id, {}).should == 'category'
      end

    end
    
    context "An instance of the Category class" do
      when_populating Category,   :from => 'getCategoryDetails' do
        value_for :name,                    :is => '1003'
        value_for :product_count,           :is => 754           
        value_for :parent_id,               :is => 406
        value_for :id,                      :is => 418
      end
      
        should "have a collection of products" do
          category_id = '123'

          category = Category.new
          category.expects(:id).with().returns(category_id)

          Product.expects(:find_all_by_category_id).with(category_id, {}).returns('products')

          category.products.should == 'products'
        end
    end
  end
end
