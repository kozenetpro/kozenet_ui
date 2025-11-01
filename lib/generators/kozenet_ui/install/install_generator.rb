# frozen_string_literal: true

require "rails/generators/base"

module KozenetUi
  module Generators
    # Generator for installing Kozenet UI into a Rails application
    # Copies stylesheets, creates initializer, and updates application CSS
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      desc "Install Kozenet UI into your application"

      def create_initializer
        template "kozenet_ui.rb", "config/initializers/kozenet_ui.rb"
      end

      def copy_stylesheets
        say "📦 Copying Kozenet UI stylesheets...", :blue
        setup_directories
        copy_main_stylesheets
        copy_component_stylesheets
        say "✅ Stylesheets copied successfully!", :green
      end

      def add_stylesheets_to_application
        css_file = find_application_css
        return warn_no_css_file unless css_file

        update_css_file(css_file)
      end

      def show_readme
        display_success_message
      end

      private

      def setup_directories
        dest_dir = Rails.root.join("app/assets/stylesheets/kozenet_ui")
        FileUtils.mkdir_p(dest_dir)
        FileUtils.mkdir_p(dest_dir.join("components"))
      end

      def copy_main_stylesheets
        %w[tokens.css base.css components.css].each do |file|
          copy_stylesheet_file(file)
        end
      end

      def copy_component_stylesheets
        component_files = Dir.glob(File.join(gem_stylesheets_path, "components", "*.css"))
        component_files.each { |src| copy_component_file(src) }
      end

      def copy_stylesheet_file(filename)
        src = File.join(gem_stylesheets_path, filename)
        dest = Rails.root.join("app/assets/stylesheets/kozenet_ui", filename)

        if File.exist?(src)
          FileUtils.cp(src, dest)
          say "  ✓ Copied #{filename}", :green
        else
          say "  ✗ #{filename} not found!", :red
        end
      end

      def copy_component_file(src_path)
        filename = File.basename(src_path)
        dest = Rails.root.join("app/assets/stylesheets/kozenet_ui/components", filename)
        FileUtils.cp(src_path, dest)
        say "  ✓ Copied components/#{filename}", :green
      end

      def gem_stylesheets_path
        @gem_stylesheets_path ||= begin
          gem_spec = Gem::Specification.find_by_name("kozenet_ui")
          File.join(gem_spec.gem_dir, "app/assets/stylesheets/kozenet_ui")
        end
      end

      def find_application_css
        %w[
          app/assets/stylesheets/application.tailwind.css
          app/assets/stylesheets/application.css
        ].find { |path| File.exist?(path) }
      end

      def update_css_file(css_file)
        content = File.read(css_file)

        if content.include?("kozenet_ui/base.css")
          say "File unchanged! Kozenet UI styles already present", :yellow
        else
          append_to_file css_file, stylesheet_imports
          say "✅ Added imports to #{css_file}", :green
        end
      end

      def stylesheet_imports
        <<~CSS

          /* Kozenet UI Styles */
          @import "kozenet_ui/tokens.css";
          @import "kozenet_ui/base.css";
          @import "kozenet_ui/components.css";
        CSS
      end

      def warn_no_css_file
        say "⚠️  Could not find application CSS file", :yellow
        say "Add these imports manually:", :yellow
        say stylesheet_imports.strip, :cyan
      end

      def display_success_message
        say_header
        say_next_steps
        say_documentation
      end

      def say_header
        say "\n#{"=" * 60}", :green
        say "✅ Kozenet UI installed successfully!", :green
        say ("=" * 60).to_s, :green
      end

      def say_next_steps
        say "\nNext steps:", :cyan
        say "  1. Add to layout <head>:", :white
        say "     <%= kozenet_ui_theme_variables_tag %>", :yellow
        say "\n  2. Restart server:", :white
        say "     bin/dev", :yellow
        say "\n  3. Use components:", :white
        say "     <%= kz_button { 'Click me' } %>", :yellow
        say "\n  4. Customize colors:", :white
        say "     config/initializers/kozenet_ui.rb", :yellow
      end

      def say_documentation
        say "\n📚 Documentation: https://github.com/kozenetpro/kozenet_ui\n\n", :blue
      end
    end
  end
end
