# frozen_string_literal: true

module KozenetUi
  # Helper methods for rendering SVG icons in Kozenet UI
  module IconHelper
    def kozenet_ui_icon(name, options = {})
      heroicon_name = normalize_icon_name(name)
      return render_heroicon(heroicon_name, options) if defined?(heroicon)

      render_fallback_icon(name, options)
    end

    private

    def normalize_icon_name(name)
      name.to_s.tr("_", "-").to_sym
    end

    def render_heroicon(name, options)
      heroicon(name, **options)
    rescue StandardError
      render_fallback_icon(name, options)
    end

    def render_fallback_icon(name, options)
      app_path = "icons/#{name}.svg"
      gem_path = "kozenet_ui/icons/#{name}.svg"
      app_full_path = Rails.root.join("app/assets/images", app_path)
      path = File.exist?(app_full_path) ? app_path : gem_path
      image_tag(asset_path(path), options)
    end
  end
end
