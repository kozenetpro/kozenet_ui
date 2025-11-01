[![Ruby CI](https://github.com/kozenetpro/kozenet_ui/actions/workflows/main.yml/badge.svg?branch=master&job=ruby)](https://github.com/kozenetpro/kozenet_ui/actions/workflows/main.yml?query=branch%3Amaster+job%3Aruby)
[![Kozenet UI CI](https://github.com/kozenetpro/kozenet_ui/actions/workflows/main.yml/badge.svg)](https://github.com/kozenetpro/kozenet_ui/actions/workflows/main.yml)
# Kozenet UI

Beautiful, minimal, Apple-inspired UI components for Rails.

## Installation

Add to your Gemfile:

```ruby
gem "kozenet_ui", github: "kozenetpro/kozenet_ui"
```

Then run:

```bash
bundle install
```

If you want to use a released version from RubyGems.org (after release):

```bash
bundle add kozenet_ui
```

Or:

```bash
gem install kozenet_ui
```

## Usage in your Rails app

1. **Add the theme variables tag to your layout `<head>`:**
   ```erb
   <%= kozenet_ui_theme_variables_tag %>
   ```

2. **Import Kozenet UI styles in your main application.css:**
   ```css
   @import "kozenet_ui/tokens.css";
   @import "kozenet_ui/base.css";
   @import "kozenet_ui/components.css";
   ```

3. **(Optional) Override icons:**
   Place your own SVGs in `app/assets/images/icons/` to override the gem's icons.

4. **Customize colors in `config/initializers/kozenet_ui.rb`.**

5. **Use components in your views:**
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
