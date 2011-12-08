# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Dummy::Application.configure do
  config.colorize_logging = true
  config.log_level = :debug
end
Dummy::Application.initialize!
