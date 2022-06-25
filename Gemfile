# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |_repo| "https://github.com/#{repo}.git" }

ruby '3.1.0'

gem 'aasm'
gem 'active_model_serializers'
gem 'apipie-rails'
gem 'bootsnap', require: false
gem 'devise'
gem 'faker'
gem 'figaro'
gem 'jwt'
gem 'pg', '~> 1.1'
gem 'pry'
gem 'puma', '~> 5.0'
gem 'rack-cors'
gem 'rails', '~> 7.0.2', '>= 7.0.2.3'
gem 'redis'
gem 'rspec'
gem 'rspec-rails'
gem 'sidekiq'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'database_cleaner-active_record'
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot'
  gem 'letter_opener'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  gem 'spring'
end
