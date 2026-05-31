# frozen_string_literal: true

module KozenetUi
  # Helper methods for rendering SVG icons in Kozenet UI
  module IconHelper
    include RailsHeroicon::Helper

    def kozenet_ui_icon(name, options = {})
      heroicon(normalize_icon_name(name), **options)
    rescue RailsHeroicon::UndefinedIcon => e
      raise ArgumentError, "Unknown Heroicon `#{name}`. Use a valid icon name from Heroicons.", e.backtrace
    end

    private

    def normalize_icon_name(name)
      name.to_s.tr("_", "-")
    end
  end
end
