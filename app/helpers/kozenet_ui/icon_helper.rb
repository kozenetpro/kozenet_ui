# frozen_string_literal: true

module KozenetUi
  module IconHelper
    # Renders a Heroicon SVG from the gem's assets
    # Usage: kozenet_ui_icon(:cart, class: "w-5 h-5 text-gray-500")
    def kozenet_ui_icon(name, options = {})
      app_path = "icons/#{name}.svg"
      gem_path = "kozenet_ui/icons/#{name}.svg"
      app_full_path = Rails.root.join("app/assets/images", app_path)
      path = File.exist?(app_full_path) ? app_path : gem_path
      image_tag(asset_path(path), options)
    end
  end
end
