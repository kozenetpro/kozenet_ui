# frozen_string_literal: true

module KozenetUi
  module Theme
    # Variant mappings for components
    # Maps semantic variants to Tailwind classes
    class Variants
      BUTTON = {
        primary: "kz-variant-primary",
        secondary: "kz-variant-secondary",
        accent: "kz-variant-accent",
        success: "kz-variant-success",
        warning: "kz-variant-warning",
        error: "kz-variant-error",
        ghost: "kz-variant-ghost",
        outline: "kz-variant-outline"
      }.freeze

      BADGE = {
        primary: "kz-badge-primary",
        secondary: "kz-badge-secondary",
        success: "kz-badge-success",
        warning: "kz-badge-warning",
        error: "kz-badge-error",
        info: "kz-badge-info"
      }.freeze

      SIZES = {
        xs: "kz-size-xs",
        sm: "kz-size-sm",
        md: "kz-size-md",
        lg: "kz-size-lg",
        xl: "kz-size-xl"
      }.freeze

      class << self
        def button(variant)
          BUTTON[variant] || BUTTON[:primary]
        end

        def badge(variant)
          BADGE[variant] || BADGE[:primary]
        end

        def size(size)
          SIZES[size] || SIZES[:md]
        end
      end
    end
  end
end