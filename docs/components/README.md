# Component Docs

This folder is the public usage guide for Kozenet UI components. Each component gets one Markdown file with the same shape so the documentation can grow without becoming messy.

## Components

- [Avatar](./avatar.md)
- [Badge](./badge.md)
- [Button](./button.md)
- [Header](./header.md)

Shared UI foundations live in [../foundations](../foundations/README.md).

## Documentation Pattern

Each component page should include:

- Purpose: when to use the component.
- Quick usage: the recommended helper API.
- Direct render: the ViewComponent API.
- Options: accepted options and defaults.
- Examples: common production patterns.
- Best practices: how to keep apps clean, fast, and consistent.

## Rails Setup

Load Kozenet UI once in your application layout:

```erb
<%= javascript_importmap_tags %>
<%= kozenet_ui_head_tags %>
```

Configure global defaults in `config/initializers/kozenet_ui.rb`:

```ruby
KozenetUi.configure do |config|
  config.theme = :system
  config.stimulus_prefix = "kz"
  config.component :header, sticky: true, blur: true
end
```

Per-render options should always win over initializer defaults.
