module Dawanda
  
  # = Request
  # 
  # A basic wrapper around GET requests to the Dawanda JSON API
  #
  class Request
    
    # The base URL for API requests
    def self.base_url
      url = "http://#{Dawanda.country}.dawanda.com/api/v1"
    end
    
    # Perform a GET request for the resource with optional parameters - returns
    # A Response object with the payload data
    # 
    def self.get(resource_path, parameters = {})
      parameters = {:format => 'json'}.update(parameters)
      request = Request.new(resource_path, parameters)
      Response.new(request.get)
    end
    
    # Create a new request for the resource with optional parameters
    def initialize(resource_path, parameters = {})
      @resource_path = resource_path
      @parameters    = parameters
    end

    # Perform a GET request against the API endpoint and return the raw
    # response data
    def get
      response = Net::HTTP.get_response(endpoint_uri)
      case response
      when Net::HTTPSuccess, Net::HTTPRedirection
        return response.body
      else 
        raise response.body
      end
    end
    
    def parameters # :nodoc:
      @parameters.merge(:api_key => Dawanda.api_key)
    end
    
    def query # :nodoc:
      parameters.map {|k,v| "#{k}=#{v}"}.join('&')
    end
    
    def endpoint_uri # :nodoc:
      uri = URI.parse("#{self.class.base_url}#{@resource_path}")
      uri.query = query
      uri
    end
    
  end
end