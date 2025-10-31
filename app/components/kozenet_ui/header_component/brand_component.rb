# frozen_string_literal: true

module KozenetUi
  class HeaderComponent < BaseComponent
    # Brand section for the HeaderComponent
    # Renders the brand/logo area, typically on the left of the header
    #
    # @example
    #   <%= render KozenetUi::HeaderComponent::BrandComponent.new(href: root_path) do %>
    #     <%= image_tag "logo.svg", alt: "Logo" %>
    #     <span>MyBrand</span>
    #   <% end %>
    class BrandComponent < BaseComponent
      def initialize(href: "#", **html_options)
        super(**html_options)
        @href = href
      end

      def call
        tag.a(href: @href, class: brand_classes) do
          safe_join([content])
        end
      end

      private

      def brand_classes
        "kz-brand"
      end
    end
  end
end
