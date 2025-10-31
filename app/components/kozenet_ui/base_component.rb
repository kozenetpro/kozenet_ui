# frozen_string_literal: true

module KozenetUi
  # Base component that all Kozenet UI components inherit from
  # Provides common functionality for variant handling, class merging, etc.
  class BaseComponent < ViewComponent::Base
    attr_reader :variant, :size, :html_options

    def initialize(variant: nil, size: nil, class: nil, **html_options)
      super()
      @variant = variant || KozenetUi.configuration.default_variant
      @size = size || KozenetUi.configuration.default_size
      @custom_class = binding.local_variable_get(:class)
      @html_options = html_options
    end

    private

    # Build final CSS classes
    def component_classes
      [
        base_classes,
        variant_class,
        size_class,
        @custom_class
      ].compact.join(" ")
    end

    # Override in subclasses
    def base_classes
      "kz-component"
    end

    # Get variant class from Variants helper
    def variant_class
      return nil unless @variant

      component_type = self.class.name.demodulize.underscore.gsub("_component", "")
      begin
        KozenetUi::Theme::Variants.public_send(component_type, @variant)
      rescue StandardError
        nil
      end
    end

    # Get size class from Variants helper
    def size_class
      return nil unless @size

      KozenetUi::Theme::Variants.size(@size)
    end

    # Merge HTML attributes safely
    def html_attrs
      @html_options.merge(class: component_classes)
    end

    # Helper for rendering slots with fallback
    def render_slot_or_content(slot, &fallback)
      if slot?
        slot
      elsif fallback
        capture(&fallback)
      end
    end

    # Check if running in dark mode (from request or config)
    def dark_mode?
      helpers.cookies[:theme] == "dark"
    rescue StandardError
      false
    end

    # Get current theme palette
    def theme_palette
      KozenetUi.configuration.palette
    end

    # Stimulus controller name with prefix
    def stimulus_controller(name)
      "#{KozenetUi.configuration.stimulus_prefix}-#{name}"
    end
  end
end
