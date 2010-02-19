# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_dawanda_oauth_client_session',
  :secret      => '74273b17d54b2d51f8c625c9702881ab9061b0d07b77942ead7cb59b76fcce84ffe916f9bf0aea58bcf8ab822a85eb3a4cc607b539c8c5608bf3a0e24070d7bc'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
