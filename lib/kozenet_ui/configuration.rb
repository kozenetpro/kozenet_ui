# frozen_string_literal: true

module KozenetUi
  # Configuration for Kozenet UI gem
  class Configuration
    DEFAULT_COMPONENT_DEFAULTS = {
      header: {
        sticky: true,
        blur: true
      }
    }.freeze

    attr_accessor :palette, :default_variant, :default_size, :theme
    attr_reader :component_defaults, :stimulus_prefix

    def initialize
      @palette = Theme::Palette.new
      @default_variant = :primary
      @default_size = :md
      @theme = :system
      @stimulus_prefix = "kz"
      @component_defaults = DEFAULT_COMPONENT_DEFAULTS.transform_values(&:dup)
    end

    # Allow custom color overrides including gradients
    def customize_colors(colors = {})
      @palette = Theme::Palette.new(colors)
    end

    # Configure global defaults for a component.
    #
    # Per-render component options still take priority:
    #   config.component :header, sticky: false
    #   kz_header(sticky: true) # overrides the global default
    def component(name, defaults = nil, **options)
      key = name.to_sym
      values = symbolize_keys((defaults || {}).merge(options))
      @component_defaults[key] = component_defaults_for(key).merge(values)
    end

    def component_defaults_for(name)
      @component_defaults.fetch(name.to_sym, {}).dup
    end

    def stimulus_prefix=(prefix)
      normalized_prefix = prefix.to_s.strip.tr("_", "-")
      @stimulus_prefix = normalized_prefix.empty? ? "kz" : normalized_prefix
    end

    private

    def symbolize_keys(hash)
      hash.to_h.transform_keys(&:to_sym)
    end
  end
end
