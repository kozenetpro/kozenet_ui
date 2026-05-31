# frozen_string_literal: true

# Helper methods for rendering Kozenet UI components in views
module KozenetUi
  # Helper methods for rendering Kozenet UI components in views
  module ComponentHelper
    include KozenetUi::IconHelper

    # Render a Kozenet UI button
    def kz_button(**options, &block)
      render(KozenetUi::ButtonComponent.new(**options), &block)
    end

    # Render a Kozenet UI header
    def kz_header(**options, &block)
      render(KozenetUi::HeaderComponent.new(**options), &block)
    end

    # Render a Kozenet UI badge
    def kz_badge(**options, &block)
      render(KozenetUi::BadgeComponent.new(**options), &block)
    end

    # Render a Kozenet UI avatar
    def kz_avatar(**options, &block)
      render(KozenetUi::AvatarComponent.new(**options), &block)
    end

    # Include theme styles in layout
    def kozenet_ui_stylesheet_tag
      stylesheet_link_tag "kozenet_ui/tokens", "kozenet_ui/fonts", "kozenet_ui/base", "kozenet_ui/components"
    end

    # Include theme JavaScript
    def kozenet_ui_javascript_tag
      javascript_include_tag "kozenet_ui/index", type: "module"
    end

    # Inject inline theme variables (CSP-compliant)
    def kozenet_ui_theme_variables_tag
      # rubocop:disable Rails/OutputSafety
      content_tag(:style, kozenet_ui_theme_variables, nonce: content_security_policy_nonce)
      # rubocop:enable Rails/OutputSafety
    end

    def kozenet_ui_theme_variables
      # rubocop:disable Rails/OutputSafety
      palette = KozenetUi.configuration.palette
      light_palette = palette.to_css_variables(mode: :light)
      dark_palette = palette.to_css_variables(mode: :dark)
      tokens = KozenetUi::Theme::Tokens.to_css_variables

      case KozenetUi.configuration.theme
      when :dark, "dark"
        <<~CSS.html_safe
          :root {
            color-scheme: dark;
            #{tokens}
            #{dark_palette}
          }
          [data-theme="light"], .light {
            color-scheme: light;
            #{light_palette}
          }
        CSS
      when :system, "system"
        <<~CSS.html_safe
          :root {
            color-scheme: light;
            #{tokens}
            #{light_palette}
          }
          @media (prefers-color-scheme: dark) {
            :root:not([data-theme="light"]) {
              color-scheme: dark;
              #{dark_palette}
            }
          }
          [data-theme="dark"], .dark {
            color-scheme: dark;
            #{dark_palette}
          }
          [data-theme="light"], .light {
            color-scheme: light;
            #{light_palette}
          }
        CSS
      else
        <<~CSS.html_safe
          :root {
            color-scheme: light;
            #{tokens}
            #{light_palette}
          }
          [data-theme="dark"], .dark {
            color-scheme: dark;
            #{dark_palette}
          }
        CSS
      end
      # rubocop:enable Rails/OutputSafety
    end
  end
end
