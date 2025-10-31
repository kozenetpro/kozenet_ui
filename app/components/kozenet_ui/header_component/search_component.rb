# frozen_string_literal: true

module KozenetUi
  class HeaderComponent < BaseComponent
    # Search section for the HeaderComponent
    # Renders a search input or form in the header
    #
    # @example
    #   <%= render KozenetUi::HeaderComponent::SearchComponent.new(placeholder: "Search...") %>
    class SearchComponent < BaseComponent
      # rubocop:disable Metrics/MethodLength
      def initialize(options = {})
        placeholder = options.fetch(:placeholder, "Search...")
        name = options.fetch(:name, "q")
        value = options.fetch(:value, nil)
        action = options.fetch(:action, "#")
        method = options.fetch(:method, :get)
        html_options = options.fetch(:html_options, {})
        super(**html_options)
        @placeholder = placeholder
        @name = name
        @value = value
        @action = action
        @method = method
      end
      # rubocop:enable Metrics/MethodLength
    end
  end
end
