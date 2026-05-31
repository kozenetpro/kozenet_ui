# frozen_string_literal: true

require "rails/generators/base"

module KozenetUi
  module Generators
    # Generator for installing Kozenet UI into a Rails application
      # Copies stylesheets, creates initializer, and adds runtime tags
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
        say "Kozenet UI stylesheets will be loaded from kozenet_ui_head_tags", :blue
      end

      def add_tags_to_layout
        layout_file = find_application_layout
        return warn_no_layout_file unless layout_file

        update_layout_file(layout_file)
      end

      def add_importmap_pins
        importmap_file = find_importmap_file
        return unless importmap_file

        update_importmap_file(importmap_file)
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
        %w[tokens.css fonts.css base.css].each do |file|
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

      def find_application_layout
        %w[
          app/views/layouts/application.html.erb
        ].find { |path| File.exist?(path) }
      end

      def find_importmap_file
        "config/importmap.rb" if File.exist?("config/importmap.rb")
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

      def update_layout_file(layout_file)
        content = File.read(layout_file)

        if content.include?("kozenet_ui_head_tags")
          say "Layout unchanged! Kozenet UI head tags already present", :yellow
          return
        end

        remove_legacy_layout_tags(layout_file, content)
        insert_layout_tags(layout_file)
        say "✅ Added Kozenet UI runtime tags to #{layout_file}", :green
      end

      def remove_legacy_layout_tags(layout_file, content)
        return unless content.match?(/kozenet_ui_(theme_variables|javascript)_tag/)

        gsub_file layout_file, /^\s*<%=\s*kozenet_ui_theme_variables_tag\s*%>\n/, ""
        gsub_file layout_file, /^\s*<%=\s*kozenet_ui_javascript_tag\s*%>\n/, ""
      end

      def insert_layout_tags(layout_file)
        content = File.read(layout_file)
        head_tags = layout_uses_app_stylesheet_bundle?(content) ? "kozenet_ui_head_tags(stylesheets: false)" : "kozenet_ui_head_tags"

        if content.include?("javascript_importmap_tags")
          insert_into_file(
            layout_file,
            "    <%= #{head_tags} %>\n",
            after: /^\s*<%=\s*javascript_importmap_tags\s*%>\n/
          )
        else
          insert_into_file layout_file, "    <%= #{head_tags} %>\n", before: %r{^\s*</head>}
        end
      end

      def layout_uses_app_stylesheet_bundle?(content)
        content.match?(/stylesheet_link_tag\s+:app\b/)
      end

      def update_importmap_file(importmap_file)
        content = File.read(importmap_file)

        if content.include?('pin "@hotwired/stimulus"')
          say "Importmap unchanged! Stimulus is already pinned", :yellow
        else
          append_to_file importmap_file, stimulus_importmap_pin
          say "✅ Added Stimulus importmap pin to #{importmap_file}", :green
        end
      end

      def stimulus_importmap_pin
        <<~RUBY

          # Required by Kozenet UI JavaScript controllers
          pin "@hotwired/stimulus", to: "stimulus.min.js"
        RUBY
      end

      def stylesheet_imports
        <<~CSS

          /* Kozenet UI Styles */
          @import "kozenet_ui/tokens.css";
          @import "kozenet_ui/fonts.css";
          @import "kozenet_ui/base.css";
          @import "kozenet_ui/components.css";
        CSS
      end

      def warn_no_css_file
        say "⚠️  Could not find application CSS file", :yellow
        say "Add these imports manually:", :yellow
        say stylesheet_imports.strip, :cyan
      end

      def warn_no_layout_file
        say "⚠️  Could not find app/views/layouts/application.html.erb", :yellow
        say "Add this once in your layout <head>, after javascript_importmap_tags when using importmap:", :yellow
        say "<%= kozenet_ui_head_tags %>", :cyan
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
        say "  1. Kozenet UI runtime is loaded once from your layout:", :white
        say "     <%= kozenet_ui_head_tags %>", :yellow
        say "\n  2. Restart server:", :white
        say "     bin/dev", :yellow
        say "\n  3. Use components:", :white
        say "     <%= kz_button { 'Click me' } %>", :yellow
        say "\n  4. Customize colors and component defaults:", :white
        say "     config/initializers/kozenet_ui.rb", :yellow
      end

      def say_documentation
        say "\n📚 Documentation: https://github.com/kozenetpro/kozenet_ui\n\n", :blue
      end
    end
  end
end
