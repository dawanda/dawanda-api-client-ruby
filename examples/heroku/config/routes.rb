ActionController::Routing::Routes.draw do |map|
  
  map.root    :controller => 'channels', :action => 'index'
  
  map.resources :channels, :only => [:index, :show], :has_many => :categories
  map.resources :categories, :only => [:index, :show]
  map.resources :products, :only => [:show]
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
