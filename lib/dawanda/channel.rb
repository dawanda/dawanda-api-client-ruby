module Dawanda
  
  # = Channel
  #
  # Dawanda::Channel are a top hierachy to categories.
  #
  # Represents a single Dawanda::Channel - has the following attributes:
  #
  # [id] The unique identifier for this channel
  # [name] This channels's name 
  # [categories] The categories that belong to this channel
  #
  class Channel
    
    include Dawanda::Model

    finder :all, '/:method'
    finder :one, '/channels/:channel_id'
    
    attributes :id, :name
    
    # Get all categories for this channel.
    def categories(params = {})
      @categories ||= Category.find_all_by_channel_id(id, params)
    end

    def self.all(params = {})
      find_all_by_method('channels')
    end
  end
end