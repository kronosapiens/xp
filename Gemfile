source 'https://rubygems.org'

ruby "2.1.0"

# Use Chosen to handle selection fields
gem 'chosen-rails'
# Use Omniauth and Octokit for Github authentication and API interaction
gem 'omniauth-github'
gem 'octokit'
# Use Chronic for parsing lesson's specific_time input from admin user
gem 'chronic'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.0.rc2'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.2'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Using Figaro for handling secrets
gem 'figaro', git: "https://github.com/laserlemon/figaro.git"

#Using Coveralls for test coverage reporting
gem 'coveralls', require: false

group :test, :development do
  gem "rspec-rails"
  gem "capybara"
  gem "selenium-webdriver"
  gem "better_errors"
  gem "sprockets_better_errors"
  gem "binding_of_caller"
  gem "factory_girl_rails"
  gem "faker"
  gem "simplecov"
  gem "database_cleaner"
  gem "sqlite3"
  gem "pry"
end

group :production do
  gem "pg"
  gem "google-analytics-rails"
  gem "rails_12factor"
end

gem "bootstrap-sass", "~> 3.1.1"

