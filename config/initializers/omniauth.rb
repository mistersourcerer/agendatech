consumer_key = ENV['TWITTER_CONSUMER_KEY']
consumer_secret = ENV['TWITTER_CONSUMER_SECRET']

Rails.application.config.middleware.use OmniAuth::Builder do  
  provider :twitter, consumer_key, consumer_secret
end 

Twitter.configure do |config|
  config.consumer_key = consumer_key
  config.consumer_secret = consumer_secret
  config.oauth_token = ENV['TWITTER_OAUTH_TOKEN']
  config.oauth_token_secret = ENV['TWITTER_OAUTH_TOKEN_SECRET']
end
