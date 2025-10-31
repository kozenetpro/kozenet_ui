# frozen_string_literal: true

require_relative "kozenet_ui/version"
require_relative "kozenet_ui/engine"
require_relative "kozenet_ui/configuration"
require_relative "kozenet_ui/theme/tokens"
require_relative "kozenet_ui/theme/palette"
require_relative "kozenet_ui/theme/variants"

module KozenetUi
  class Error < StandardError; end

  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    # Reset configuration (useful for testing)
    def reset_configuration!
      @configuration = Configuration.new
    end
  end
end