class ProductsController < ApplicationController
  
  def show
    @product = Dawanda::Product.find_by_id(params[:id])
  end
  
end