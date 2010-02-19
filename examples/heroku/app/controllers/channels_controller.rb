class ChannelsController < ApplicationController
  
  def index
    begin
      @channels = Dawanda::Channel.all
    rescue Exception => e
      flash[:error] =  JSON.parse(e.message)['error']['message'] rescue 'Unknown error'
      render :file => 'shared/error'
    end
    
  end
  
  def show
    begin
      @channel = Dawanda::Channel.find_by_channel_id(params[:id])
      @categories = @channel.categories(:page => @page)
    rescue Exception => e
      flash[:error] =  JSON.parse(e.message)['error']['message'] rescue 'Unknown error'
      render :file => 'shared/error'
    end
  end
  
  def children
    @categorie = Dawanda::Category.find_by_id(params[:id]).children
    render :action => :index
  end
end
# 
# require 'rubygems'
# require 'lib/dawanda'
# Dawanda.api_key = 'cdfff20ec201b327434ec3ceb30d186a984bc98b'
# Dawanda::Channel.all