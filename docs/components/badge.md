# Badge

Use `BadgeComponent` for statuses, labels, counters, categories, and small metadata.

## Quick Usage

```erb
<%= kz_badge(variant: :success) { "Published" } %>
```

## Direct Render

```erb
<%= render KozenetUi::BadgeComponent.new(variant: :warning, size: :sm) do %>
  Pending
<% end %>
```

## Options

| Option | Default | Description |
| --- | --- | --- |
| `variant` | `:primary` | Visual style. |
| `size` | `:md` | Badge size. |
| `pill` | `true` | Uses rounded pill shape. |
| `**html_options` | `{}` | Extra HTML attributes. |

## Variants

```erb
<%= kz_badge(variant: :primary) { "Primary" } %>
<%= kz_badge(variant: :secondary) { "Secondary" } %>
<%= kz_badge(variant: :accent) { "Accent" } %>
<%= kz_badge(variant: :success) { "Success" } %>
<%= kz_badge(variant: :warning) { "Warning" } %>
<%= kz_badge(variant: :error) { "Error" } %>
<%= kz_badge(variant: :info) { "Info" } %>
```

## Count Badge

```erb
<%= kz_badge(variant: :primary, size: :sm) { "99+" } %>
```

## Category Badge

```erb
<%= kz_badge(variant: :accent) { blog.category_name } %>
```

## With Icon

```erb
<%= kz_badge(variant: :warning) do |badge| %>
  <% badge.with_icon do %>
    <%= kozenet_ui_icon(:clock, size: 14) %>
  <% end %>
  Pending
<% end %>
```

## Less Rounded

```erb
<%= kz_badge(variant: :secondary, pill: false) { "Draft" } %>
```

## Best Practices

- Keep text short: one to three words.
- Use semantic variants for state: `:success`, `:warning`, `:error`.
- Use `:accent` for brand/category emphasis.
- Avoid using badges as buttons. Use `kz_button` for actions.
