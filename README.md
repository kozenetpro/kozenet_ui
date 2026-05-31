[![Ruby CI](https://github.com/kozenetpro/kozenet_ui/actions/workflows/main.yml/badge.svg?branch=master&job=ruby)](https://github.com/kozenetpro/kozenet_ui/actions/workflows/main.yml?query=branch%3Amaster+job%3Aruby)
[![Kozenet UI CI](https://github.com/kozenetpro/kozenet_ui/actions/workflows/main.yml/badge.svg)](https://github.com/kozenetpro/kozenet_ui/actions/workflows/main.yml)
# Kozenet UI

Beautiful, minimal, Apple-inspired UI components for Rails.

## Installation

For local gem development, point the Rails app at this checkout:

```ruby
gem "kozenet_ui", path: "../.."
```

Then run:

```bash
bundle install
bin/rails generate kozenet_ui:install
```

For an app outside this repository, use GitHub:

```ruby
gem "kozenet_ui", github: "kozenetpro/kozenet_ui"
```

Or use the released RubyGems version:

```bash
bundle add kozenet_ui
```

Then run:

```bash
bin/rails generate kozenet_ui:install
```

`gem install kozenet_ui` is not enough for a Rails app. The app must have
`kozenet_ui` in its `Gemfile`, because Rails generators are loaded through
Bundler.

## Usage in your Rails app

Usage guides live in [docs](docs/README.md):

- [Components](docs/components/README.md)
- [Fonts](docs/foundations/fonts.md)

1. **Load Kozenet UI once from your layout `<head>`:**
   ```erb
   <%= kozenet_ui_head_tags %>
   ```

   This loads digested CSS assets, theme variables, and JavaScript. When using
   importmap, keep this after `javascript_importmap_tags`.

   In Rails 8 apps using `stylesheet_link_tag :app`, the install generator
   copies Kozenet UI styles into `app/assets/stylesheets/kozenet_ui` and inserts:

   ```erb
   <%= kozenet_ui_head_tags(stylesheets: false) %>
   ```

2. **Customize copied styles when needed:**
   The install generator copies Kozenet UI CSS into
   `app/assets/stylesheets/kozenet_ui`, so developers can edit the frontend
   without touching gem internals.

3. **Only use CSS imports when you have a CSS bundler:**
   ```css
   @import "kozenet_ui/tokens.css";
   @import "kozenet_ui/fonts.css";
   @import "kozenet_ui/base.css";
   @import "kozenet_ui/components/button.css";
   @import "kozenet_ui/components/header.css";
   @import "kozenet_ui/components/avatar.css";
   @import "kozenet_ui/components/badge.css";
   @import "kozenet_ui/components/utilities.css";
   ```

   For plain Propshaft/Sprockets apps, prefer `kozenet_ui_head_tags`, because
   stylesheet tags generate digest-safe production asset URLs.

4. **Skip direct stylesheet tags if your app bundles the CSS itself:**
   ```erb
   <%= kozenet_ui_head_tags(stylesheets: false) %>
   ```

5. **Use Heroicons by name:**
   ```erb
   <% header.with_action_button(href: "/saved", icon: :heart, label: "Saved") %>
   <% header.with_action_button(href: "/cart", icon: :shopping_cart, label: "Cart") %>
   ```

   Kozenet UI normalizes Ruby-style names like `:shopping_cart` to Heroicons'
   `shopping-cart` name.

6. **Customize colors and component defaults in `config/initializers/kozenet_ui.rb`:**
   ```ruby
   KozenetUi.configure do |config|
     config.theme = :system
     config.stimulus_prefix = "kz"
     config.component :header, sticky: true, blur: true
   end
   ```

   Per-render options still win:
   ```erb
   <%= kz_header(sticky: false) do |header| %>
     ...
   <% end %>
   ```

7. **Use components in your views:**
   ```erb
   <%= render KozenetUi::HeaderComponent.new do |header| %>
     ...
   <% end %>
   ```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kozenetpro/kozenet_ui. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/kozenetpro/kozenet_ui/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the KozenetUi project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/kozenetpro/kozenet_ui/blob/main/CODE_OF_CONDUCT.md).
