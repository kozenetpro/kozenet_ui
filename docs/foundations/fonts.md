# Fonts

Kozenet UI ships with self-hosted web fonts and exposes them through CSS variables. This keeps the gem easy to install, avoids runtime CDN requests, and lets Rails serve/cache font assets through the app.

## Included Fonts

| Variable | Default Font | Purpose |
| --- | --- | --- |
| `--kz-font-sans` | `Inter` | Main UI text. |
| `--kz-font-serif` | `Source Serif 4` | Editorial/article text when wanted. |
| `--kz-font-mono` | `JetBrains Mono` | Code, IDs, technical labels. |

Kozenet UI also exposes compatibility aliases:

```css
--font-sans: var(--kz-font-sans);
--font-serif: var(--kz-font-serif);
--font-mono: var(--kz-font-mono);
```

## Load Fonts

The install generator adds this import to your application CSS:

```css
@import "kozenet_ui/fonts.css";
```

Keep it before `base.css` and `components.css`:

```css
@import "kozenet_ui/tokens.css";
@import "kozenet_ui/fonts.css";
@import "kozenet_ui/base.css";
@import "kozenet_ui/components.css";
```

If you are using direct stylesheet tags instead of CSS imports:

```erb
<%= kozenet_ui_head_tags(stylesheets: true) %>
```

## Use Font Variables

Use variables in app CSS instead of hardcoding font names:

```css
.post-title {
  font-family: var(--kz-font-sans);
}

.post-body {
  font-family: var(--kz-font-serif);
}

.code-label {
  font-family: var(--kz-font-mono);
}
```

## Override Fonts Globally

Override the variables after Kozenet UI imports:

```css
@import "kozenet_ui/tokens.css";
@import "kozenet_ui/fonts.css";
@import "kozenet_ui/base.css";
@import "kozenet_ui/components.css";

:root {
  --kz-font-sans: "Aptos", ui-sans-serif, system-ui, sans-serif;
  --kz-font-serif: Georgia, ui-serif, serif;
  --kz-font-mono: "SFMono-Regular", ui-monospace, monospace;
}
```

## Use Your Own Self-Hosted Font

Add font files to your Rails app, for example:

```text
app/assets/fonts/acme-sans.woff2
```

Then define your font and point Kozenet UI variables at it:

```css
@font-face {
  font-family: "Acme Sans";
  src: url("acme-sans.woff2") format("woff2");
  font-style: normal;
  font-weight: 100 900;
  font-display: swap;
}

:root {
  --kz-font-sans: "Acme Sans", ui-sans-serif, system-ui, sans-serif;
}
```

## Disable Bundled Web Fonts

If the app should use only system fonts, remove or skip the `fonts.css` import and define the variables yourself:

```css
@import "kozenet_ui/tokens.css";
@import "kozenet_ui/base.css";
@import "kozenet_ui/components.css";

:root {
  --kz-font-sans: ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
  --kz-font-serif: ui-serif, Georgia, Cambria, "Times New Roman", Times, serif;
  --kz-font-mono: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace;
  --font-sans: var(--kz-font-sans);
  --font-serif: var(--kz-font-serif);
  --font-mono: var(--kz-font-mono);
}
```

## Performance Notes

- Fonts are WOFF2 and use `font-display: swap`.
- Load font CSS once globally, not per page.
- Prefer variable fonts instead of many separate weights.
- Keep custom font families small: one sans, one optional serif, one optional mono.
- Avoid external font CDNs when a Rails app can serve the font locally.

## Best Practices

- Components should use font variables, not hardcoded font families.
- App-specific screens can override fonts at the page or section level.
- Use `--kz-font-sans` for operational UI.
- Use `--kz-font-serif` only where editorial reading benefits from it.
- Use `--kz-font-mono` for technical data, code, or short identifiers.
