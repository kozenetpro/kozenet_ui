# frozen_string_literal: true

require "rails/generators/base"

module KozenetUi
  module Generators
    # Generator for installing Kozenet UI into a Rails application
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      desc "Install Kozenet UI into your application"

      def create_initializer
        template "kozenet_ui.rb", "config/initializers/kozenet_ui.rb"
      end

      def copy_css_files_to_app
        # do NOT copy CSS files to the app. Let the gem expose them via the asset pipeline.
        say "Kozenet UI stylesheets are now available via the asset pipeline. " \
            "Import them in your Tailwind/application.css:", :green
        say "\n@import 'kozenet_ui/tokens.css';\n@import 'kozenet_ui/base.css';" \
            "\n@import 'kozenet_ui/components.css';\n", :cyan
      end

      # rubocop:disable Metrics/MethodLength
      def add_stylesheets_to_application
        tailwind_css = nil
        tailwind_css = "app/assets/stylesheets/application.css" if File.exist?("app/assets/stylesheets/application.css")

        if tailwind_css
          content = File.read(tailwind_css)
          kozenet_imports = "\n/* Kozenet UI Styles */\n" \
            "@import 'kozenet_ui/tokens.css';\n" \
            "@import 'kozenet_ui/base.css';\n" \
            "@import 'kozenet_ui/components.css';\n"

          if content.include?("kozenet_ui/base.css")
            say "File unchanged! Kozenet UI styles already present in #{tailwind_css}", :yellow
          else
            append_to_file tailwind_css, kozenet_imports
            say "Appended Kozenet UI styles to #{tailwind_css}", :green
          end
        else
          say "Could not find app/assets/stylesheets/application.css. " \
              "Please manually import Kozenet UI stylesheets.", :yellow
        end
      end
      # rubocop:enable Metrics/MethodLength

      def show_readme
        say "\n✅ Kozenet UI installed successfully!", :green
        say "\nNext steps:", :cyan
        say "  1. Add <%= kozenet_ui_theme_variables_tag %> to your layout <head>"
        say "  2. Customize colors in config/initializers/kozenet_ui.rb"
        say "  3. Start using components: <%= kz_button { 'Click me' } %>"
        say "\nDocumentation: https://github.com/kozenetpro/kozenet_ui\n"
      end

      def install
        create_initializer
        copy_css_files_to_app
        add_stylesheets_to_application
        show_readme
      end
    end
  end
end
