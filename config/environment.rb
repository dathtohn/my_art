# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
MyArt::Application.initialize!

Date::DATE_FORMATS[:default] = '%b %d, %Y'
