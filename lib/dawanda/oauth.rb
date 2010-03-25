module Dawanda
  
  # = OAuth
  #
  # Provides access to sesitive user data
  
  class OAuth
    API_PREFIX = '/api/v1/oauth'
    
    def self.connect key=nil, secret=nil, params={}
      @@key = key if key
      @@secret = secret if secret

      raise "You did not provide a OAuth secret or key" if not @@key or not @@secret
      
      @@consumer = ::OAuth::Consumer.new(@@key, @@secret, {
        :site               => "http://#{Dawanda.country}.#{Dawanda.domain}",
        :request_token_path => "/oauth/request_token",
        :access_token_path  => "/oauth/access_token",
        :authorize_path     => "/oauth/authorize"
      })
      
      if params["oauth_verifier"].present?
        @@request_token = ::OAuth::RequestToken.from_hash(@@consumer, params) 
        @@request_token.consumer.options.merge!({:oauth_verifier => params[:oauth_verifier]})
        @@access_token = @@request_token.get_access_token
      else
        @@request_token = @@consumer.get_request_token  
      end
    end
    
    def self.authorize_url
      @@request_token.authorize_url
    end
    
    def self.access_token
      @@access_token ||= nil
    end

    def self.access_token=(access_token)
      @@access_token = access_token
    end

    def self.get(url, options={})
      Dawanda::Response.new(@@access_token.get(url).body)
    end

    def self.user
      Dawanda::User.new(Dawanda::OAuth.get("#{API_PREFIX}/users.json").result)
    end
  end
end
