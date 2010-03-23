module Dawanda
  
  # = Request
  # 
  # A basic wrapper around GET requests to the Dawanda JSON API
  #
  class Request
    
    # The base URL for API requests
    def self.base_url
      url = "http://#{Dawanda.country}.#{Dawanda.domain}/api/v1"
    end
    
    # Perform a GET request for the resource with optional parameters - returns
    # A Response object with the payload data
    # 
    def self.get(resource_path, parameters = {})
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
      request = Net::HTTP::Get.new endpoint_uri.path
      request.basic_auth Dawanda.http_basic[:user], Dawanda.http_basic[:password] if Dawanda.http_basic
      request.set_form_data parameters
      response = Net::HTTP.new(endpoint_uri.host, endpoint_uri.port).start {|http| http.request(request) }
      
      case response
      when Net::HTTPSuccess, Net::HTTPRedirection
        return response.body
      else 
        raise response.body
      end
    end
    
    def parameters # :nodoc:
      @parameters.merge(:api_key => Dawanda.api_key, :format => 'json')
    end
    
    def endpoint_uri # :nodoc:
      URI.parse("#{self.class.base_url}#{@resource_path}")
    end
  end
end
