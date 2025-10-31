# frozen_string_literal: true

require "color"

module KozenetUi
  module Theme
    # Dynamic color palette system with auto-generated shades
    # Supports light/dark modes and custom brand colors
    class Palette
      DEFAULT_COLORS = {
        primary: "#6366f1",    # Indigo
        secondary: "#8b5cf6",  # Purple
        accent: "#06b6d4",     # Cyan
        success: "#10b981",    # Green
        warning: "#f59e0b",    # Amber
        error: "#ef4444",      # Red
        info: "#0ea5e9"        # Sky
      }.freeze

      # Neutral colors (semantic)
      NEUTRALS_LIGHT = {
        bg_base: "#ffffff",
        bg_elevated: "#f8fafc",
        bg_muted: "#f1f5f9",
        text_default: "#0f172a",
        text_muted: "#64748b",
        border_default: "#e2e8f0",
        border_muted: "#f1f5f9"
      }.freeze

      NEUTRALS_DARK = {
        bg_base: "#0f172a",
        bg_elevated: "#1e293b",
        bg_muted: "#334155",
        text_default: "#f1f5f9",
        text_muted: "#94a3b8",
        border_default: "#334155",
        border_muted: "#1e293b"
      }.freeze

      attr_reader :colors

      def initialize(custom_colors = {})
        @colors = DEFAULT_COLORS.merge(custom_colors)
      end

      # Generate CSS custom properties for all colors, including gradient tokens
      def to_css_variables(mode: :light)
        variables = []

        # Brand colors with shades (only for valid hex colors)
        @colors.each do |name, hex|
          next if name.to_s.start_with?("gradient_spot_")
          next if name.to_s.end_with?("_dark")

          if hex.is_a?(String) && hex.match?(/^#(?:[0-9a-fA-F]{3}){1,2}$/)
            shades = generate_shades(hex)
            shades.each do |shade, color|
              variables << "--kz-#{name}-#{shade}: #{color};"
            end
          else
            # For non-hex, just output as a base variable
            variables << "--kz-#{name}: #{hex};"
          end
        end

        # Semantic neutrals
        neutrals = mode == :dark ? NEUTRALS_DARK : NEUTRALS_LIGHT
        neutrals.each do |name, value|
          variables << "--kz-#{name.to_s.tr("_", "-")}: #{value};"
        end

        # Gradient tokens (allow user to override or fallback to palette)
        if mode == :dark
          variables << "--gradient-base-from: #{@colors[:gradient_from_dark] || "#181c2a"};"
          variables << "--gradient-base-to: #{@colors[:gradient_to_dark] || "#23283a"};"
          variables << "--gradient-accent-from: #{@colors[:gradient_accent_from_dark] || "#1e40af"};"
          variables << "--gradient-accent-via: #{@colors[:gradient_accent_via_dark] || "#0369a1"};"
          variables << "--gradient-accent-to: #{@colors[:gradient_accent_to_dark] || "#0891b2"};"
          variables << "--gradient-spot-1: #{@colors[:gradient_spot_1_dark] || "rgba(56,189,248,0.20)"};"
          variables << "--gradient-spot-2: #{@colors[:gradient_spot_2_dark] || "rgba(99,102,241,0.18)"};"
        else
          variables << "--gradient-base-from: #{@colors[:gradient_from] || "#f0f9ff"};"
          variables << "--gradient-base-to: #{@colors[:gradient_to] || "#e0f2fe"};"
          variables << "--gradient-accent-from: #{@colors[:gradient_accent_from] || "#6366f1"};"
          variables << "--gradient-accent-via: #{@colors[:gradient_accent_via] || "#0ea5e9"};"
          variables << "--gradient-accent-to: #{@colors[:gradient_accent_to] || "#06b6d4"};"
          variables << "--gradient-spot-1: #{@colors[:gradient_spot_1] || "rgba(99,102,241,0.35)"};"
          variables << "--gradient-spot-2: #{@colors[:gradient_spot_2] || "rgba(14,165,233,0.30)"};"
        end

        variables.join("\n    ")
      end

      private

      # Generate 50-900 shades from a base color
      def generate_shades(hex)
        base = Color::RGB.by_hex(hex)

        {
          50 => lighten(base, 0.45).html,
          100 => lighten(base, 0.35).html,
          200 => lighten(base, 0.25).html,
          300 => lighten(base, 0.15).html,
          400 => lighten(base, 0.08).html,
          500 => hex, # Base color
          600 => darken(base, 0.08).html,
          700 => darken(base, 0.15).html,
          800 => darken(base, 0.25).html,
          900 => darken(base, 0.35).html
        }
      end

      def lighten(color, amount)
        color.lighten_by(amount * 100)
      end

      def darken(color, amount)
        color.darken_by(amount * 100)
      end
    end
  end
end
