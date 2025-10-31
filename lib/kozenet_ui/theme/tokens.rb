# frozen_string_literal: true

module KozenetUi
  module Theme
    # Design tokens for the Kozenet UI system
    class Tokens
      # Spacing scale (in rem)
      SPACING = {
        xs: "0.25rem",   # 4px
        sm: "0.5rem",    # 8px
        md: "1rem",      # 16px
        lg: "1.5rem",    # 24px
        xl: "2rem",      # 32px
        "2xl": "3rem",   # 48px
        "3xl": "4rem"    # 64px
      }.freeze

      # Border radius (Apple-style rounded)
      RADIUS = {
        sm: "12px",
        md: "16px",
        lg: "20px",
        xl: "24px",
        "2xl": "28px",
        full: "9999px"
      }.freeze

      # Typography scale
      FONT_SIZE = {
        xs: "0.65rem",    # 10.4px
        sm: "0.75rem",    # 12px
        base: "0.875rem", # 14px
        lg: "1rem",       # 16px
        xl: "1.25rem",    # 20px
        "2xl": "1.5rem",  # 24px
        "3xl": "2rem"     # 32px
      }.freeze

      FONT_WEIGHT = {
        normal: "400",
        medium: "500",
        semibold: "600",
        bold: "700"
      }.freeze

      # Shadows for depth effects
      SHADOW = {
        sm: "0 1px 2px rgba(0,0,0,.05), 0 2px 6px -2px rgba(0,0,0,.08)",
        md: "0 4px 14px -6px rgba(0,0,0,.25)",
        lg: "0 10px 30px -12px rgba(0,0,0,.45)",
        xl: "0 20px 60px -26px rgba(0,0,0,.28)"
      }.freeze

      # Transitions
      TRANSITION = {
        fast: "0.15s ease",
        base: "0.25s ease",
        slow: "0.35s ease"
      }.freeze

      # Z-index layers
      Z_INDEX = {
        dropdown: "50",
        sticky: "60",
        modal: "70",
        popover: "80",
        toast: "90"
      }.freeze

      class << self
        # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity
        def to_css_variables
          variables = []

          # Spacing
          SPACING.each { |key, value| variables << "--kz-spacing-#{key}: #{value};" }

          # Radius
          RADIUS.each { |key, value| variables << "--kz-radius-#{key}: #{value};" }

          # Typography
          FONT_SIZE.each { |key, value| variables << "--kz-font-size-#{key}: #{value};" }
          FONT_WEIGHT.each { |key, value| variables << "--kz-font-weight-#{key}: #{value};" }

          # Shadows
          SHADOW.each { |key, value| variables << "--kz-shadow-#{key}: #{value};" }

          # Transitions
          TRANSITION.each { |key, value| variables << "--kz-transition-#{key}: #{value};" }

          # Z-index
          Z_INDEX.each { |key, value| variables << "--kz-z-#{key}: #{value};" }

          variables.join("\n          ")
        end
        # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity
      end
    end
  end
end
