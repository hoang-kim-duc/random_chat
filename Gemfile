source 'https://rubygems.org'
git_source(:github) { |repo| 'https://github.com/#{repo}.git' }

ruby '3.1.0'

gem 'rails', '~> 7.0.2', '>= 7.0.2.3'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'tzinfo-data', platforms: %i[ mingw mswin x64_mingw jruby ]
gem 'bootsnap', require: false
gem 'rack-cors'
gem 'devise'
gem 'pry'
gem 'apipie-rails'
gem 'figaro'
gem 'redis'
gem 'aasm'

group :development, :test do
  gem 'debug', platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem 'spring'
end
