source 'https://rubygems.org'

# Heroku uses ruby 1.9.2, incompatible with mongodb
group :production do
  source "https://rubygems.org"
  ruby "1.9.3"
end

gem 'rails'

gem 'bootstrap-sass'
gem 'devise'
gem 'google-api-client'
gem 'omniauth-google-oauth2'
gem 'will_paginate'
gem 'mongoid', '3.0.5'
gem 'geocoder', '1.1.5' # Has to be AFTER mongoid
gem 'gmaps4rails'

group :development do
  gem 'annotate'
  gem 'faker'
  gem 'rspec-rails'
end
group :test do
  gem 'factory_girl_rails'
  gem 'rspec'
  gem 'webrat'
end
group :development, :test do
  gem 'spork'
  # gem 'sqlite3'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
