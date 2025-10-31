# frozen_string_literal: true

module KozenetUi
  class HeaderComponent < BaseComponent
    # NavItem section for the HeaderComponent
    # Renders a navigation item (link/button) in the header
    #
    # @example
    #   <%= render KozenetUi::HeaderComponent::NavItemComponent.new(href: "/path", active: true) { "Home" } %>
    class NavItemComponent < BaseComponent
      def initialize(href: "#", active: false, dropdown: false, **html_options)
        super(**html_options)
        @href = href
        @active = active
        @dropdown = dropdown
      end

      private

      def nav_item_classes
        classes = ["kz-nav-link"]
        classes << "is-active" if @active
        classes << @custom_class if defined?(@custom_class) && @custom_class
        classes.join(" ")
      end
    end
  end
end
