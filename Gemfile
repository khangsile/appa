source 'https://rubygems.org'
ruby '2.0.0'

# Paperclip for pictures
gem 'paperclip'

gem 'aws-s3', :require => 'aws/s3'

# Tagging
gem 'acts-as-taggable-on'

# Authenticate fb tokens for mobile app
gem 'fb_graph'

gem 'therubyracer', :group => :assets
# gem 'libv8'

gem 'gcm'

gem 'cancan'

gem 'redis-rails'

gem "resque" #, "~> 2.0.0.pre.1", github: "resque/resque"

group :production do
	# Postgresql
	gem 'pg'
end

gem 'activerecord-postgis-adapter'
gem 'rgeo'

gem 'newrelic_rpm'

# For heroku
# gem 'rails_12factor', group: :production

group :development, :test do
	# Use sqlite3 as the database for Active Record
	# gem 'sqlite3'
	gem 'pg'

	# For debugging
	gem 'debugger'

	# Use rspec for testing
	gem 'rspec-rails'
	gem 'rspec'
	
	# Use FactoryGirl to create dummy objects for DB
	gem 'factory_girl_rails'
	# Use capybara for testing
	gem "capybara"
end

# Rable for JSON api templating
gem 'rabl'

# Twitter bootstrap
gem 'anjlab-bootstrap-rails', :require => 'bootstrap-rails',
                          :github => 'anjlab/bootstrap-rails',
                          :branch => '3.0.0'

# Use stripe library
# gem 'stripe', :git => 'https://github.com/stripe/stripe-ruby'

# Include devise gem for authentication system
gem 'devise'

# Omniauth gem for facebook oauth
gem 'omniauth'
gem 'omniauth-facebook'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
gem 'rubber'
gem 'open4'
gem 'gelf'
gem 'graylog2_exceptions', :git => 'git://github.com/wr0ngway/graylog2_exceptions.git'
gem 'graylog2-resque'
gem 'resque', :require => 'resque/server'
gem 'resque-pool'
gem 'puma'
