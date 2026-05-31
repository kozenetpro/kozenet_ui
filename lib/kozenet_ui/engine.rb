# frozen_string_literal: true

require "rails/engine"
require "view_component"

module KozenetUi
  # Rails engine for Kozenet UI gem
  class Engine < ::Rails::Engine
    isolate_namespace KozenetUi

    # Add generators path
    config.generators do |g|
      g.test_framework :rspec
    end

    # This is CRITICAL - tells Rails where to find generators
    config.app_generators.scaffold_controller = :scaffold_controller

    initializer "kozenet_ui.generators" do
      # Explicitly add generators path
      config.generators do |g|
        g.templates.unshift File.expand_path("../generators", __dir__)
      end
    end

    # Configure where to look for components
    if Rails.env.development? && config.view_component&.preview_paths
      config.view_component.preview_paths << "#{root}/spec/components/previews"
    end

    # Add assets paths (for Rails 7/Sprockets only)
    if config.respond_to?(:assets) && config.assets.respond_to?(:paths)
      config.assets.paths << root.join("app/assets/fonts")
      config.assets.paths << root.join("app/assets/stylesheets")
      config.assets.paths << root.join("app/assets/javascripts")

      # Precompile assets
      config.assets.precompile += %w[
        kozenet_ui/fonts.css
        kozenet_ui/tokens.css
        kozenet_ui/base.css
        kozenet_ui/components.css
        kozenet_ui/components/avatar.css
        kozenet_ui/components/badge.css
        kozenet_ui/components/button.css
        kozenet_ui/components/header.css
        kozenet_ui/components/utilities.css
        kozenet_ui/index.js
        kozenet_ui/inter-latin.woff2
        kozenet_ui/source-serif-4-latin.woff2
        kozenet_ui/jetbrains-mono-latin.woff2
      ]
    end

    # Auto-load components
    config.autoload_paths << root.join("app/components")
    config.eager_load_paths << root.join("app/components")

    # Make helpers available
    initializer "kozenet_ui.helpers" do
      ActiveSupport.on_load(:action_controller_base) do
        helper KozenetUi::ComponentHelper
      end
    end

    # Inject CSS variables into layout
    initializer "kozenet_ui.theme_injection", after: :load_config_initializers do
      ActiveSupport.on_load(:action_view) do
        ActiveSupport.on_load(:action_view) { prepend ThemeHelper }
      end
    end

    initializer "kozenet_ui.assets" do |app|
      # Only add asset paths and precompile for Sprockets (classic asset pipeline)
      if app.config.respond_to?(:assets) && app.config.assets.respond_to?(:paths)
        %w[
          app/assets/stylesheets/kozenet_ui
          app/assets/stylesheets/kozenet_ui/components
          app/assets/fonts
        ].each do |path|
          app.config.assets.paths << root.join(path)
        end
        app.config.assets.precompile += %w[
          kozenet_ui/fonts.css
          kozenet_ui/tokens.css
          kozenet_ui/base.css
          kozenet_ui/components.css
          kozenet_ui/components/avatar.css
          kozenet_ui/components/badge.css
          kozenet_ui/components/button.css
          kozenet_ui/components/header.css
          kozenet_ui/components/utilities.css
          kozenet_ui/inter-latin.woff2
          kozenet_ui/source-serif-4-latin.woff2
          kozenet_ui/jetbrains-mono-latin.woff2
        ]
      end
    end
  end

  # Helper methods for injecting Kozenet UI theme variables into views
  module ThemeHelper
    def kozenet_ui_theme_tag
      content_tag(:style, kozenet_ui_theme_variables, nonce: content_security_policy_nonce)
    end

    def kozenet_ui_theme_variables
      build_theme_css
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
          /* Design Tokens */
          #{tokens}
          /* Color Palette (Dark Mode) */
          #{dark_palette}
        }

        [data-theme="light"], .light {
          color-scheme: light;
          /* Color Palette (Light Mode) */
          #{light_palette}
        }
      CSS
    end

    def build_system_theme_css(tokens, light_palette, dark_palette)
      <<~CSS
        :root {
          color-scheme: light;
          /* Design Tokens */
          #{tokens}
          /* Color Palette (Light Mode) */
          #{light_palette}
        }

        @media (prefers-color-scheme: dark) {
          :root:not([data-theme="light"]):not(.light) {
            color-scheme: dark;
            /* Color Palette (Dark Mode) */
            #{dark_palette}
          }
        }

        [data-theme="dark"], .dark {
          color-scheme: dark;
          /* Color Palette (Dark Mode) */
          #{dark_palette}
        }

        [data-theme="light"], .light {
          color-scheme: light;
          /* Color Palette (Light Mode) */
          #{light_palette}
        }
      CSS
    end

    def build_light_theme_css(tokens, light_palette, dark_palette)
      <<~CSS
        :root {
          color-scheme: light;
          /* Design Tokens */
          #{tokens}
          /* Color Palette (Light Mode) */
          #{light_palette}
        }

        [data-theme="dark"], .dark {
          color-scheme: dark;
          /* Color Palette (Dark Mode) */
          #{dark_palette}
        }
      CSS
    end
  end
end
