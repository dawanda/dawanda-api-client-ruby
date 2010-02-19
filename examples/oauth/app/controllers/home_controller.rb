class HomeController < ApplicationController
  def index
    if logged_in?
      token = current_user.access_token(:dawanda)
      
      if token
        @user = JSON.parse(token.get('/api/v1/oauth/users.json').body)["response"]["result"]["user"] rescue nil
        @orders = JSON.parse(token.get("/api/v1/oauth/orders.json").body)["response"]["result"]["orders"] rescue []
        date = Time.now.strftime("%Y/%m/%d")
        @orders_from_today = JSON.parse(token.get("/api/v1/oauth/orders.json?from=2009/12/17").body)["response"]["result"]["orders"] rescue nil
      end
    end
  end
end