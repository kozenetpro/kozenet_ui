# frozen_string_literal: true

require "rails/engine"
require "view_component"

module KozenetUi
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
    config.view_component.preview_paths << "#{root}/spec/components/previews" if Rails.env.development?

    # Add assets paths (for Rails 7/Sprockets only)
    if config.respond_to?(:assets) && config.assets.respond_to?(:paths)
      config.assets.paths << root.join("app/assets/stylesheets")
      config.assets.paths << root.join("app/assets/javascripts")

      # Precompile assets
      config.assets.precompile += %w[
        kozenet_ui/tokens.css
        kozenet_ui/base.css
        kozenet_ui/components.css
        kozenet_ui/index.js
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
      if app.config.respond_to?(:assets) && app.config.assets.respond_to?(:paths)
        app.config.assets.paths << root.join("app/assets/stylesheets/kozenet_ui")
        app.config.assets.paths << root.join("app/assets/stylesheets/kozenet_ui/components")
        app.config.assets.paths << root.join("app/assets/images/kozenet_ui/icons")
      end
    end
  end

  module ThemeHelper
    def kozenet_ui_theme_tag
      content_tag(:style, kozenet_ui_theme_variables, nonce: content_security_policy_nonce)
    end

    def kozenet_ui_theme_variables
      palette = KozenetUi.configuration.palette
      tokens = KozenetUi::Theme::Tokens

      <<~CSS
        :root {
          /* Design Tokens */
          #{tokens.to_css_variables}
        #{"  "}
          /* Color Palette (Light Mode) */
          #{palette.to_css_variables(mode: :light)}
        }

        [data-theme="dark"], .dark {
          /* Color Palette (Dark Mode) */
          #{palette.to_css_variables(mode: :dark)}
        }
      CSS
    end
  end
end
