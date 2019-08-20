source 'https://rubygems.org'

group :development, :production, :test do
  gem 'sinatra', '2.0.5', require: 'sinatra/base'
  gem 'mongoid', '7.0.1'
  gem 'draper' , '3.1.0'
  gem 'arkaan' , '1.6.1'
end

group :developement, :production do
  gem 'rake'
  gem 'capistrano', '3.11.0'
  gem 'capistrano-bundler', '1.5.0'
  gem 'capistrano-rvm', '0.1.1'
end

group :development, :test do
  gem 'faker'                  , '1.9.3'
  gem 'pry'                    , '0.11.1'
  gem 'rack-test'              , '0.7.0' , require: 'rack/test'
  gem 'rspec'                  , '3.6.0'
  gem 'rspec-json_expectations', '2.1.0'
  gem 'factory_bot'            , '5.0.2'
  gem 'simplecov'              , '0.15.1'
  gem 'database_cleaner'       , '1.6.1'
  gem 'bcrypt'                 , '3.1.11'
  gem 'rubocop'
  gem 'yard'
  gem 'rspec_junit_formatter'  , '0.4.1'
end