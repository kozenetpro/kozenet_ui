ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../dummy/config/environment", __FILE__)
require "rspec/rails"

# Optionally, load view_component test helpers
require "view_component/test_helpers"

RSpec.configure do |config|
  config.include ViewComponent::TestHelpers, type: :component
  config.infer_spec_type_from_file_location!
end
