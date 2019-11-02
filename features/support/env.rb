# If you want to use a different mock framework than
# RSpec-Mocks - just set configure that accordingly
#
# require 'rspec/core'
# RSpec.configure do |c|
#  c.mock_framework = :rspec
#  c.mock_framework = :mocha
#  c.mock_framework = :rr
#  c.mock_framework = :flexmock
# end

ENV['RACK_ENV'] = 'test'

require 'capybara'
require 'capybara/cucumber'
require 'cucumber/rspec/doubles'
require 'rack/test'
require 'rspec/expectations'

class SinatraWorld
  require 'selenium-webdriver'
  Capybara.default_driver = :selenium

  # Uncomment if you wish to use Chrome instead of Firefox
  # Download the ChromeDriver from: https://code.google.com/p/selenium/wiki/ChromeDriver
  #
  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, :browser => :chrome)
  end

  # use the rackup file to load the apps w/their respective URL mappings, sweet!
  Capybara.app = eval "Rack::Builder.new {( #{File.read(File.dirname(__FILE__) + '/../../config.ru')}\n )}"

  # Before do
  #   Fixtures.reset_cache
  #   fixtures_folder = File.join(RAILS_ROOT, 'spec', 'fixtures')
  #   fixtures = Dir[File.join(fixtures_folder, '*.yml')].map {|f| File.basename(f, '.yml') }
  #   Fixtures.create_fixtures(fixtures_folder, fixtures)
  # end

  include Capybara::DSL
  include RSpec::Expectations
end

World do
  SinatraWorld.new
end