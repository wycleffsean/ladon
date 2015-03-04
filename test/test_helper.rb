require 'simplecov'
require 'minitest/autorun'
require 'coveralls'

if ENV['COVERALLS']
  Coveralls.wear!
end

require 'ladon'

Ladon::OauthProviderBuilder.build('Example') do
  application_id 'example_id'
  application_secret 'example_secret'
  authorization do
    url 'https://example.com/api/authorize'
    request {
      duration 'permanent'
      redirect_uri 'https://localhost/oauth/callback'
    }
  end
  
  grant do
  end
end

=begin
OAuthProvider.build('Reddit') do
  #name ||= class_name
  application_id ENV['REDDIT_APP_ID']
  application_secret ENV['REDDIT_APP_SECRET']
  request_authorization do
    url 'https://www.reddit.com/api/v1/authorize'
    request {
      #state
      #scope
      #client_id
      duration 'permanent'
      redirect_uri OAUTH_REDIRECT_ROUTE
      response_type 'code'
    }
  end
  retrieve_token do
    url 'https://www.reddit.com/api/v1/access_token'
    request {
      #code
      grant_type 'authorization_code'
      redirect_uri OAUTH_REDIRECT_ROUTE
    }
    response {
      access_token
      token_type ->(t){ t.tr!('%','') }
      scope
      expires_in
      refresh_token
    }
  end
end

 
OauthProvider::Reddit.authorization_form
provider = OAuthProvider.get_provider state: '...', code: '...'
#provider = OAuthProvider::Reddit.new code: '...'
access_token = provider.retrieve_token # AccessToken
access_token.user_id = current_user
=end
