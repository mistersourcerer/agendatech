source :rubygems
gem "mysql2"
gem 'rails', '3.2.11'
gem "paperclip"
gem "twitter", "4.5.0"
gem "omniauth-twitter"
gem "devise"
gem "icalendar"
gem "friendly_id"
#gem 'shorturl'
gem 'validates_timeliness'
gem "omniauth"
gem "aws-s3"
gem "dalli"
gem "enumerate_it"
gem 'aws-sdk'
gem "nokogiri", "1.5.4" #dependencia indireta na versão que não buga no Ubuntu

group :development, :test do
  gem "rspec-rails", "~> 2.6"
  gem "pry-rails"
end

group :test do
  gem "shoulda-matchers"
  gem "cucumber-rails", :require => false
  gem "database_cleaner", :require => false
  gem "capybara"
end

group :production do
   gem "pg"
end
