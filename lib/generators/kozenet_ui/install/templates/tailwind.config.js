module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/components/**/*.{rb,erb}',
    // Include Kozenet UI components
    './vendor/bundle/ruby/**/kozenet_ui-*/app/{components,helpers,views}/**/*.{rb,erb}'
  ],
  darkMode: ['class', '[data-theme="dark"]'],
  theme: {
    extend: {
      colors: {
        // Your custom colors will be available via CSS variables
      }
    }
  },
  plugins: []
}