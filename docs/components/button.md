# Button

Use `ButtonComponent` for primary actions, secondary actions, links that should look like buttons, and loading or disabled states.

## Quick Usage

```erb
<%= kz_button { "Save changes" } %>
```

```erb
<%= kz_button(variant: :secondary, size: :lg) { "Preview" } %>
```

## Direct Render

```erb
<%= render KozenetUi::ButtonComponent.new(variant: :primary, size: :md) do %>
  Save changes
<% end %>
```

## Options

| Option | Default | Description |
| --- | --- | --- |
| `variant` | `:primary` | Visual style. |
| `size` | `:md` | Button size. |
| `type` | `:button` | Native button type. |
| `href` | `nil` | Renders an anchor when present. |
| `disabled` | `false` | Disables the action visually and semantically. |
| `loading` | `false` | Shows spinner and marks the button busy. |
| `full_width` | `false` | Makes the button fill the available width. |
| `html_options` | `{}` | Extra HTML attributes. |

## Variants

```erb
<%= kz_button(variant: :primary) { "Primary" } %>
<%= kz_button(variant: :secondary) { "Secondary" } %>
<%= kz_button(variant: :accent) { "Accent" } %>
<%= kz_button(variant: :success) { "Success" } %>
<%= kz_button(variant: :warning) { "Warning" } %>
<%= kz_button(variant: :error) { "Error" } %>
<%= kz_button(variant: :ghost) { "Ghost" } %>
<%= kz_button(variant: :outline) { "Outline" } %>
```

## Sizes

```erb
<%= kz_button(size: :xs) { "XS" } %>
<%= kz_button(size: :sm) { "SM" } %>
<%= kz_button(size: :md) { "MD" } %>
<%= kz_button(size: :lg) { "LG" } %>
<%= kz_button(size: :xl) { "XL" } %>
```

## Link Button

```erb
<%= kz_button(href: pricing_path, variant: :ghost) { "View pricing" } %>
```

## Loading State

```erb
<%= kz_button(loading: true) { "Saving..." } %>
```

## With Icon

```erb
<%= kz_button(variant: :secondary) do |button| %>
  <% button.with_icon do %>
    <%= kozenet_ui_icon(:arrow_down_tray, size: 18) %>
  <% end %>
  Download
<% end %>
```

## Form Submit

```erb
<%= form_with model: @post do |form| %>
  <%= kz_button(type: :submit, variant: :primary) { "Publish" } %>
<% end %>
```

## Best Practices

- Use `:primary` for one main action per screen or section.
- Use `:secondary`, `:ghost`, or `:outline` for supporting actions.
- Use `loading: true` while a submission is in progress.
- Use `href:` only for navigation. Use button submit types for forms.
