source 'https://rubygems.org'
ruby RUBY_VERSION

gem 'sinatra', '~> 2.0', '>= 2.0.3', :require => 'sinatra/base'
gem 'sinatra-contrib', '~> 2.0', '>= 2.0.3'
gem 'bcrypt', '~> 3.1', '>= 3.1.12'
gem 'aws-sdk', '~> 3'
gem 'datamapper', '~> 1.2.0'
gem 'slim', '~> 3.0', '>= 3.0.9'
gem 'thin', '~> 1.7', '>= 1.7.2'
gem 'oj', '~> 3.6', '>= 3.6.6'
gem 'padrino-gen', '~> 0.14.3'
gem 'padrino-helpers', '~> 0.14.3'
gem 'dotenv', '~> 2.6'

group :development, :test do
  gem 'rake', '~> 12.3', '>= 12.3.1'
  gem 'rack', '~> 2.0', '>= 2.0.6'
  gem 'cucumber', '~> 3.1', '>= 3.1.2'
  gem 'capybara', '~> 3.6'
  gem 'selenium-webdriver', '~> 3.14'
  gem 'rack-test', '~> 1.1'
  gem 'rspec', '~> 3.8'
  gem 'dm-sqlite-adapter', '~> 1.2.0'
end

group :production do
  gem 'dm-mysql-adapter', '~> 1.2.0'
end
