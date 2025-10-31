# frozen_string_literal: true

module KozenetUi
  class HeaderComponent < BaseComponent
    # Search section for the HeaderComponent
    # Renders a search input or form in the header
    #
    # @example
    #   <%= render KozenetUi::HeaderComponent::SearchComponent.new(placeholder: "Search...") %>
    class SearchComponent < BaseComponent
      def initialize(placeholder: "Search...", name: "q", value: nil, action: "#", method: :get, **html_options)
        super(**html_options)
        @placeholder = placeholder
        @name = name
        @value = value
        @action = action
        @method = method
      end
    end
  end
end
