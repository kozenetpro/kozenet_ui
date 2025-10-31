# frozen_string_literal: true

require "kozenet_ui"

# Autoload all components for specs
$LOAD_PATH.unshift File.expand_path("../app/components", __dir__)

# Ensure KozenetUi::BaseComponent is loaded first
require_relative "../app/components/kozenet_ui/base_component"
# Autoload all other components
Dir[File.expand_path("../app/components/kozenet_ui/**/*.rb", __dir__)].sort.each do |f|
  require f unless f.end_with?("base_component.rb")
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
