class CategoriesController < ApplicationController

  before_filter :get_channel
  
  def index
    @categories = Dawanda::Category.find_all_by_channel_id(@channel.id, :page => @page)
  end
  
  def show
    @category = Dawanda::Category.find_by_id(params[:id])
  end
  
  protected
  
  def get_channel
    channel_id = params[:channel_id]
    @channel = Dawanda::Channel.find_by_channel_id(channel_id)
  end
  
end