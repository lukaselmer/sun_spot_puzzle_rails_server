# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_spotpuzzle_rails_server_session',
  :secret      => '0e2fdc6e64dea46fe90cd5fb2beec83c61628c49ba2bf47d9a28cc9bda6604ef8666f65110f5625a3e80eae4ad3edbe74db7558647d3f588c332abfa3747fa4c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
