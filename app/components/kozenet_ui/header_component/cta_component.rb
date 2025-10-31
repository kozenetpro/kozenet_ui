# frozen_string_literal: true

module KozenetUi
  class HeaderComponent < BaseComponent
    # CTA (Call To Action) section for the HeaderComponent
    # Renders a prominent call-to-action button or link in the header
    #
    # @example
    #   <%= render KozenetUi::HeaderComponent::CtaComponent.new(href: "/signup") { "Get Started" } %>
    class CtaComponent < BaseComponent
      def initialize(href: "#", **html_options)
        super(**html_options)
        @href = href
      end

      private

      def cta_classes
        "kz-cta"
      end
    end
  end
end
