require File.join(File.dirname(__FILE__), '..', 'stored_sheet.rb')

require 'sinatra'
require 'rack/test'
require 'rspec'
require 'capybara/rspec'
require 'database_cleaner'

# set test environment
set :environment, :test
setup_mongoid
set :run, false
set :raise_errors, true
set :logging, false

include Rack::Test::Methods

def app
  @app ||= Sinatra::Application
end

Capybara.app = app

Capybara.register_driver :selenium_chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

# if Selenium::WebDriver::Platform.find_binary "chromedriver"
  Capybara.javascript_driver = :selenium_chrome
# else
#   Capybara.javascript_driver = :selenium
# end


RSpec.configure do |config|
   config.before(:suite) do
     DatabaseCleaner[:mongoid].strategy = :truncation
   end

   config.before(:each) do
     DatabaseCleaner[:mongoid].start
   end

   config.after(:each) do
     DatabaseCleaner[:mongoid].clean
   end
end




