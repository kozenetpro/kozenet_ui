# frozen_string_literal: true

module KozenetUi
  class Configuration
    attr_accessor :palette, :default_variant, :default_size, :theme, :stimulus_prefix

    def initialize
      @palette = Theme::Palette.new
      @default_variant = :primary
      @default_size = :md
      @theme = :system
      @stimulus_prefix = "kz"
    end

    # Allow custom color overrides including gradients
    def customize_colors(colors = {})
      @palette = Theme::Palette.new(colors)
    end
  end
end
