# Avatar

Use `AvatarComponent` for people, teams, authors, and account menu triggers.

## Quick Usage

```erb
<%= kz_avatar(src: user.avatar_url, alt: user.name) %>
```

## Direct Render

```erb
<%= render KozenetUi::AvatarComponent.new(initials: "KP", variant: :primary) %>
```

## Options

| Option | Default | Description |
| --- | --- | --- |
| `src` | `nil` | Image URL. |
| `alt` | `"Avatar"` | Image alt text. |
| `initials` | `nil` | Text fallback when no image is present. |
| `variant` | `:primary` | Background style for initials/default state. |
| `size` | `:md` | Avatar size. |
| `html_options` | `{}` | Extra HTML attributes. |

## Image Avatar

```erb
<%= kz_avatar(src: current_user.avatar_url, alt: current_user.name, size: :lg) %>
```

## Initials Avatar

```erb
<%= kz_avatar(initials: "JD", variant: :accent) %>
```

## Default Icon Avatar

```erb
<%= kz_avatar %>
```

## Sizes

```erb
<%= kz_avatar(initials: "XS", size: :xs) %>
<%= kz_avatar(initials: "SM", size: :sm) %>
<%= kz_avatar(initials: "MD", size: :md) %>
<%= kz_avatar(initials: "LG", size: :lg) %>
<%= kz_avatar(initials: "XL", size: :xl) %>
```

## With Extra Attributes

```erb
<%= kz_avatar(
  initials: "KP",
  html_options: {
    title: "Kozenet Pro",
    data: { testid: "author-avatar" }
  }
) %>
```

## Best Practices

- Always provide meaningful `alt` text for real user images.
- Use initials when the user has no uploaded image.
- Keep avatar size consistent inside repeated lists.
- Use the same variant for the same identity type across an app.
