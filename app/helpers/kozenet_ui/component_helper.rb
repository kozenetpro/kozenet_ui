# frozen_string_literal: true

module KozenetUi
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
      stylesheet_link_tag "kozenet_ui/tokens", "kozenet_ui/base", "kozenet_ui/components"
    end

    # Include theme JavaScript
    def kozenet_ui_javascript_tag
      javascript_include_tag "kozenet_ui/index", type: "module"
    end

    # Inject inline theme variables (CSP-compliant)
    def kozenet_ui_theme_variables_tag
      content_tag(:style, nonce: content_security_policy_nonce) do
        palette = KozenetUi.configuration.palette
        tokens = KozenetUi::Theme::Tokens

        <<~CSS.html_safe
          :root {
            #{tokens.to_css_variables}
            #{palette.to_css_variables(mode: :light)}
          }
          [data-theme="dark"], .dark {
            #{palette.to_css_variables(mode: :dark)}
          }
        CSS
      end
    end
  end
end
