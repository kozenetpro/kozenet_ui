# frozen_string_literal: true

require_relative "lib/kozenet_ui/version"

Gem::Specification.new do |spec|
  spec.name          = "kozenet_ui"
  spec.version       = KozenetUi::VERSION
  spec.authors       = ["Kozenet Pro"]
  spec.email         = ["kozenetpro@gmail.com"]

  spec.summary       = "Beautiful, minimal, Apple-inspired UI components for Rails"
  spec.description   = <<~DESC
    Kozenet UI is a modern, production-ready component library for Ruby on Rails.
    Built with ViewComponent and Tailwind CSS, it provides beautiful, accessible,
    and customizable UI components with dynamic theming support. Features CSP-compliant
    styling, dark mode, and smooth animations.
  DESC

  spec.homepage      = "https://github.com/kozenetpro/kozenet_ui"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 3.3.0"

  spec.metadata = {
    "homepage_uri" => spec.homepage,
    "source_code_uri" => "https://github.com/kozenetpro/kozenet_ui",
    "changelog_uri" => "https://github.com/kozenetpro/kozenet_ui/blob/main/CHANGELOG.md",
    "bug_tracker_uri" => "https://github.com/kozenetpro/kozenet_ui/issues",
    "documentation_uri" => "https://github.com/kozenetpro/kozenet_ui/blob/main/README.md",
    "rubygems_mfa_required" => "true"
  }

  # Include all necessary files
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir[
      "{lib,app}/**/*",
      "README.md",
      "LICENSE.txt",
      "CHANGELOG.md",
      "CODE_OF_CONDUCT.md"
    ].select { |f| File.file?(f) }
  end

  spec.require_paths = ["lib"]

  # Runtime dependencies
  spec.add_dependency "color", "~> 1.8"
  spec.add_dependency "inline_svg", "~> 1.9"
  spec.add_dependency "rails_heroicon", ">= 1.0"
  spec.add_dependency "railties", ">= 7.0", "< 9.0"
  spec.add_dependency "view_component", ">= 3.0", "< 4.0"

  # Development dependencies
  spec.add_development_dependency "bundler", ">= 2.0"
  spec.add_development_dependency "capybara", "~> 3.0"
  spec.add_development_dependency "lookbook", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec-rails", "~> 7.0"
  spec.add_development_dependency "rubocop", "~> 1.50"
  spec.add_development_dependency "rubocop-rails", "~> 2.20"
  spec.add_development_dependency "rubocop-rspec", "~> 3.0"
  spec.add_development_dependency "selenium-webdriver", "~> 4.0"
end
