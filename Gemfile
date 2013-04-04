source "https://rubygems.org"

gem "rails", git: "git://github.com/rails/rails.git"
gem "protected_attributes"
gem "friendly_id", git: "git@github.com:norman/friendly_id.git", branch: "rails4"
gem "acts-as-taggable-on"

gem "mysql2"
gem "paperclip"
gem "twitter", ">= 4.5.0"
gem "omniauth-twitter"
gem "devise"
gem "icalendar"
gem 'validates_timeliness'
gem "omniauth"
gem "aws-s3"
gem "dalli"
gem "enumerate_it"
gem 'aws-sdk'
gem "nokogiri"
gem "dynamic_form"

group :development, :test do
  gem "rspec-rails", ">= 2.6"
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
