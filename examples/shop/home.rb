require "rubygems"
require "sinatra"
require "dawanda"

before do
  Dawanda.api_key = '380d7924396f5596116f3d8815c97dfd8c975582'
  Dawanda.country = 'de'
  @page = (params[:page] || 1).to_i
  @max_page = 999
end

get "/" do
  @shop_categories = []
  @products = []
  erb :index
end

get "/shop" do
  category = Dawanda.shop(params[:username]).shop_categories.first
  redirect "/shop/#{params[:username]}/#{category.id}/1"
end

get "/shop/:username/:id/:page" do
  @shop = Dawanda.shop(params[:username])
  @shop_categories = @shop.shop_categories
  @shop_category = Dawanda.shop_category(params[:id])
  @products = @shop_category.products(:page => @page)
  
  erb :index
end