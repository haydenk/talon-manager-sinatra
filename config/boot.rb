ENV['RACK_ENV'] ||= 'development'
APP_ROOT = File.expand_path('../..', __FILE__) unless defined?(APP_ROOT)

require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
require 'data_mapper'
#require 'active_support/core_ext/hash/conversions'
Bundler.require(:default, ENV['RACK_ENV'].to_sym)

Dotenv.load

# Load the helpers
Dir['./app/helper/*.rb'].each { |f| require f }

# DataMapper::Logger.new($stdout, :debug)
# DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/db/app.db")

DataMapper.setup(:default, ENV['DATABASE_URL'])

# Perform basic sanity checks and initialize all relationships
# Call this when you've defined all your model

# Load the model
Dir['./app/model/*.rb'].each { |f| require f }
DataMapper.finalize

module MySinatraApp
  class BaseApp < Sinatra::Base
    helpers Sinatra::ApplicationHelpers

    before do
      @show_home_link = false
    end

    configure do
      set :public_folder => File.join(APP_ROOT, 'public')
      set :views => File.join(APP_ROOT,'app/view')
    end
  end
end

# Load the controllers
Dir['./app/controller/*.rb'].each { |f| require f }
