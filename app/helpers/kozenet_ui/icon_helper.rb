# frozen_string_literal: true

module KozenetUi
  # Helper methods for rendering SVG icons in Kozenet UI
  module IconHelper
    # Renders a Heroicon SVG using the rails_heroicon gem
    # Usage: kozenet_ui_icon(:cart, options)
    def kozenet_ui_icon(name, options = {})
      heroicon(name, options)
    end
  end
end
