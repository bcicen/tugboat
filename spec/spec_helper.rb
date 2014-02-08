ENV['RACK_ENV'] = 'test'

require File.expand_path('../../config/environment', __FILE__)

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(File.dirname(__FILE__), "support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.before do
    Shipr.stub workers:  double(IronWorkerNG::Client).as_null_object
    Shipr.stub messages: double(IronMQ::Client).as_null_object
    Shipr.stub pusher:   double(Pusher).as_null_object
  end

  config.before :suite do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  config.after :each do
    DatabaseCleaner.clean
  end
end
