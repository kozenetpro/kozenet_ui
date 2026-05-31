# frozen_string_literal: true

# Helper methods for rendering Kozenet UI components in views
module KozenetUi
  # Helper methods for rendering Kozenet UI components in views
  module ComponentHelper
    include KozenetUi::IconHelper

    KOZENET_UI_STYLESHEETS = [
      "kozenet_ui/tokens",
      "kozenet_ui/fonts",
      "kozenet_ui/base",
      "kozenet_ui/components/button",
      "kozenet_ui/components/header",
      "kozenet_ui/components/avatar",
      "kozenet_ui/components/badge",
      "kozenet_ui/components/utilities"
    ].freeze

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
      stylesheet_link_tag(*KOZENET_UI_STYLESHEETS, "data-turbo-track": "reload")
    end

    # Include theme JavaScript
    def kozenet_ui_javascript_tag
      javascript_include_tag "kozenet_ui/index", type: "module", "data-turbo-track": "reload"
    end

    # Include runtime tags once in the application layout.
    #
    # Stylesheets are loaded directly so Propshaft/Sprockets can emit digested
    # asset URLs in production. Apps can pass stylesheets: false when bundling
    # Kozenet UI CSS with their own build pipeline.
    def kozenet_ui_head_tags(stylesheets: true, javascript: true)
      tags = []
      tags << kozenet_ui_stylesheet_tag if stylesheets
      tags << kozenet_ui_config_tag
      tags << kozenet_ui_theme_variables_tag
      tags << kozenet_ui_javascript_tag if javascript

      safe_join(tags, "\n")
    end

    def kozenet_ui_config_tag
      tag.meta name: "kozenet-ui-stimulus-prefix", content: KozenetUi.configuration.stimulus_prefix
    end

    # Inject inline theme variables (CSP-compliant)
    def kozenet_ui_theme_variables_tag
      content_tag(:style, build_theme_css, nonce: content_security_policy_nonce)
    end

    private

    def build_theme_css
      theme_vars = compile_theme_variables
      case KozenetUi.configuration.theme
      when :dark, "dark"
        build_dark_theme_css(*theme_vars)
      when :system, "system"
        build_system_theme_css(*theme_vars)
      else
        build_light_theme_css(*theme_vars)
      end.html_safe
    end

    def compile_theme_variables
      palette = KozenetUi.configuration.palette
      [
        KozenetUi::Theme::Tokens.to_css_variables,
        palette.to_css_variables(mode: :light),
        palette.to_css_variables(mode: :dark)
      ]
    end

    def build_dark_theme_css(tokens, light_palette, dark_palette)
      <<~CSS
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
    end

    def build_system_theme_css(tokens, light_palette, dark_palette)
      <<~CSS
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
    end

    def build_light_theme_css(tokens, light_palette, dark_palette)
      <<~CSS
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
  end
end
