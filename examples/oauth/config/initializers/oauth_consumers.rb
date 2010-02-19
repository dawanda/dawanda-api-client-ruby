# edit this file to contain credentials for the OAuth services you support.
# each entry needs a corresponding token model.
#
# eg. :twitter => TwitterToken, :hour_feed => HourFeedToken etc.
#

OAUTH_CREDENTIALS={
  :dawanda=>{
    :key=>"",
    :secret=>"",
    :options=>{ # OAuth::Consumer options
      :site=>"http://de.dawanda.com" # Remember to add a site for a generic OAuth site
    }
  }
} unless defined? OAUTH_CREDENTIALS

load 'oauth/models/consumers/service_loader.rb'