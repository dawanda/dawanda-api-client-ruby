module Dawanda
  
  # = Response
  # 
  # Basic wrapper around the Dawanda JSON response data
  #
  class Response
    
    # Create a new response based on the raw JSON
    def initialize(data)
      @data = data
    end
    
    # Convert the raw JSON data to a hash
    def to_hash
      @hash ||= JSON.parse(@data)
      @hash['response']
    end
    
    # Number of records in the response
    def entries
      to_hash['entries']
    end
    
    # Number of pages in the response
    def pages
      to_hash['pages']
    end
    
    def type
      to_hash['type']
    end
    
    def pluralized_type
      type.to_s.pluralize
    end
    
    def params
      to_hash['params']
    end
    # Result of the API request that expect exactly one result
    def result
      to_hash['result'][type]
    end
    
    # Results of the API request that expect an arry of results
    def results
      to_hash['result'].values.first
    end
  end
end