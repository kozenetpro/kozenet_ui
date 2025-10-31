# frozen_string_literal: true

module KozenetUi
  class HeaderComponent < BaseComponent
    # ActionButton section for the HeaderComponent
    # Renders an action button (icon or text) in the header
    #
    # @example
    #   <%= render KozenetUi::HeaderComponent::ActionButtonComponent.new(href: "/cart", icon: :cart, label: "Cart") %>
    class ActionButtonComponent < BaseComponent
      def initialize(href: "#", icon: nil, label: nil, **html_options)
        super(**html_options)
        @href = href
        @icon = icon
        @label = label
      end

      private

      def action_button_classes
        "kz-action-btn"
      end

      def render_icon(icon)
        ApplicationController.helpers.kozenet_ui_icon(icon, class: "kz-action-btn-icon") if icon
      end
    end
  end
end
