source "https://rubygems.org"

ruby "3.3.3"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '7.1.3.4'
gem 'actionmailbox', '7.1.3.4'
gem 'actionmailer', '7.1.3.4'
gem 'mail', '2.8.1'

gem 'pg'
gem 'devise', '~> 4.9.4'
gem 'warden', '~> 1.2.9'
gem 'devise-jwt'
gem 'rack-cors', require: 'rack/cors'
gem 'jsonapi-serializer'

# Use sqlite3 as the database for Active Record
gem "sqlite3", "~> 1.4"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
# gem "rack-cors"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ]
# Gemfile
  gem 'capistrano', '~> 3.17'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano-rvm'



end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end
gem 'dotenv-rails', groups: [:development, :test]
gem "stripe"
gem "byebug"
gem 'activeadmin', '~> 3.2.2'
gem 'sass-rails', '~> 6.0'
gem 'rack', '~> 3.1.7'
gem 'railties', '~> 7.1.3.4'
gem 'active_model_serializers'
gem 'httparty'
gem 'pry'
gem 'ed25519', '~> 1.2'
gem 'bcrypt_pbkdf', '~> 1.0'
