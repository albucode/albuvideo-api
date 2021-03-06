# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'active_model_serializers'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'devise'
gem 'foreman'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.5'

gem 'aasm'
gem 'activerecord-import'
gem 'down', '~> 5.0'
gem 'm3u8'
gem 'rack-cors'
gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
gem 'rails_same_site_cookie'
gem 'redis', '~> 4.0'
gem 'rest-client'
gem 'sidekiq'
gem 'validate_url'
gem 'whenever', require: false

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end

group :test do
  gem 'rspec_junit_formatter'
  gem 'shoulda-matchers'
  gem 'webmock'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end
