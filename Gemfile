source 'https://rubygems.org'

ruby '2.5.1'
gem 'rails', '~> 5.2.0'

gem 'acts_as_list'
gem 'aws-sdk-s3'
gem 'bootstrap-sass'
gem 'business_time'
gem 'clockwork'
gem 'devise'
gem 'email_address'
gem 'haml-rails'
gem 'jbuilder'
gem 'jquery-rails'
gem 'money-rails'
gem 'newrelic_rpm'
# Rollbar suggests using this gem for JSON serialization
gem 'oj'
gem 'onfleet-ruby'
gem 'paperclip'
gem 'paperclip-fake-storage', '~> 6.0', git: 'https://github.com/buildgroundwork/paperclip-fake-storage', branch: :master
gem 'paranoia'
# ActiveRecord is not compatible with pg gem version 1.0 (yet).
gem 'pg', '~> 0.21.0'
gem 'phonelib'
gem 'puma'
gem 'pundit'
gem 'rails_12factor'
gem 'rollbar'
gem 'rqrcode'
gem 'sass-rails'
gem 'tod'
gem 'uglifier'
gem 'will_paginate'

source 'https://gems.contribsys.com/' do
  gem 'sidekiq-pro'
end

group :development, :test do
  gem 'byebug', platforms: [:mri]
  gem 'dotenv-rails'
  gem 'fixture_builder'
  gem 'jasmine'
  gem 'rails-controller-testing'
  gem 'rspec-collection_matchers'
  gem 'rspec-its'
  gem 'rspec-rails'
  gem 'timecop'
end

group :development do
  gem 'brakeman'
  gem 'license_finder'
  gem 'listen'
  gem 'rubocop'
  gem 'web-console'
end

group :test do
  gem 'webmock'
end

