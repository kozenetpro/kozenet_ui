# Header

Use `HeaderComponent` for primary application navigation. It supports brand, nav links, search, icon actions, CTA, user menu, and mobile menu slots.

## Quick Usage

```erb
<%= kz_header do |header| %>
  <% header.with_brand(href: root_path) do %>
    <span>Kozenet</span>
  <% end %>

  <% header.with_nav_item(href: posts_path, active: current_page?(posts_path)) { "Posts" } %>
  <% header.with_nav_item(href: new_post_path) { "New" } %>

  <% header.with_search(placeholder: "Search posts", action: posts_path, value: params[:q]) %>
  <% header.with_action_button(href: saved_posts_path, icon: :heart, label: "Saved") %>
  <% header.with_cta(href: new_post_path) { "New post" } %>
<% end %>
```

## Direct Render

```erb
<%= render KozenetUi::HeaderComponent.new(sticky: true, blur: true) do |header| %>
  <% header.with_brand(href: root_path) { "Brand" } %>
<% end %>
```

## Options

| Option | Default | Description |
| --- | --- | --- |
| `sticky` | initializer default, fallback `true` | Keeps header sticky at top. |
| `blur` | initializer default, fallback `true` | Enables glass/blur treatment. |
| `**html_options` | `{}` | Extra HTML attributes. |

## Global Defaults

Set project defaults in `config/initializers/kozenet_ui.rb`:

```ruby
KozenetUi.configure do |config|
  config.component :header, sticky: true, blur: true
end
```

Override for one render:

```erb
<%= kz_header(sticky: false, blur: false) do |header| %>
  <% header.with_brand(href: root_path) { "Plain Header" } %>
<% end %>
```

## Slots

| Slot | Purpose |
| --- | --- |
| `with_brand` | Brand/logo link. |
| `with_nav_item` | Primary nav links. |
| `with_search` | Header search form. |
| `with_action_button` | Icon or compact text action button. |
| `with_cta` | Main call-to-action. |
| `with_user_menu` | Account/avatar menu. |
| `with_mobile_menu` | Mobile navigation panel. |

## Brand

```erb
<% header.with_brand(href: root_path) do %>
  <span class="brand-mark">K</span>
  <span>Kozenet <span class="accent">UI</span></span>
<% end %>
```

## Nav Items

```erb
<% header.with_nav_item(href: dashboard_path, active: current_page?(dashboard_path)) { "Dashboard" } %>
<% header.with_nav_item(href: settings_path) { "Settings" } %>
```

## Search

```erb
<% header.with_search(
  placeholder: "Search",
  name: :q,
  value: params[:q],
  action: posts_path,
  method: :get
) %>
```

## Action Button

Action buttons use Heroicons names. Ruby-style names are normalized:

```erb
<% header.with_action_button(href: notifications_path, icon: :bell, label: "Notifications") %>
<% header.with_action_button(href: cart_path, icon: :shopping_cart, label: "Cart") %>
```

`label` is used for accessibility and is visually hidden in the icon-only button.

By default, action buttons render in the end group, on the right side of the desktop header. Use `placement: :start` for actions that belong at the left/start edge, such as a sidebar toggle:

```erb
<% header.with_action_button(href: "#", icon: :bars_3, label: "Open menu", placement: :start) %>
<% header.with_action_button(href: saved_posts_path, icon: :heart, label: "Saved", placement: :end) %>
```

`position: :left` and `position: :right` are accepted as aliases, but `placement: :start` and `placement: :end` are preferred.

Header action buttons are desktop-only by default so mobile headers stay clean. Use `visible_on:` when an action should appear somewhere else:

```erb
<% header.with_action_button(href: "#", icon: :bars_3, label: "Open menu", placement: :start, visible_on: :mobile) %>
<% header.with_action_button(href: settings_path, icon: :cog_6_tooth, label: "Settings", visible_on: :desktop) %>
```

Accepted values are `:desktop`, `:mobile`, and `:always`. The default is `:desktop`.

Use `text:` when the action should be visible as a compact text button:

```erb
<% header.with_action_button(href: saved_posts_path, text: "Saved", label: "Saved posts") %>
```

You can combine icon and text:

```erb
<% header.with_action_button(href: saved_posts_path, icon: :heart, text: "Saved", label: "Saved posts") %>
```

## CTA

```erb
<% header.with_cta(href: new_post_path) { "New post" } %>
```

## User Menu

```erb
<% header.with_user_menu(user_name: current_user.name, avatar_url: current_user.avatar_url) do %>
  <%= link_to "Profile", profile_path, class: "menu-link" %>
  <%= link_to "Settings", settings_path, class: "menu-link" %>
<% end %>
```

## Mobile Menu

```erb
<% header.with_mobile_menu do %>
  <nav aria-label="Mobile navigation">
    <%= link_to "Posts", posts_path %>
    <%= link_to "New post", new_post_path %>
  </nav>
<% end %>
```

## Full Example

```erb
<%= kz_header do |header| %>
  <% header.with_brand(href: root_path) do %>
    <span class="brand-mark">K</span>
    <span>Kozenet <span class="accent">Blog</span></span>
  <% end %>

  <% header.with_nav_item(href: posts_path, active: current_page?(posts_path)) { "Posts" } %>
  <% header.with_nav_item(href: new_post_path, active: current_page?(new_post_path)) { "New" } %>
  <% header.with_search(placeholder: "Search posts", action: posts_path, value: params[:q]) %>
  <% header.with_action_button(href: saved_posts_path, icon: :heart, label: "Saved") %>

  <% header.with_user_menu(user_name: "Kozenet") do %>
    <%= link_to "All posts", posts_path, class: "menu-link" %>
    <%= link_to "New post", new_post_path, class: "menu-link" %>
  <% end %>

  <% header.with_mobile_menu do %>
    <nav aria-label="Mobile navigation">
      <%= link_to "Posts", posts_path %>
      <%= link_to "New post", new_post_path %>
    </nav>
  <% end %>
<% end %>
```

## Best Practices

- Load `kozenet_ui_head_tags` once in the layout, not per page.
- Prefer initializer defaults for app-wide header behavior.
- Keep per-page overrides close to the render call.
- Use Heroicons names for icon actions.
- Always provide labels for icon-only actions.
- Keep navigation items short so desktop and mobile layouts stay balanced.
- Keep mobile actions intentional; prefer one menu/search trigger and move secondary links into `with_mobile_menu`.
