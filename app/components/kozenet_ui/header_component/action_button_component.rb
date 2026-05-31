# frozen_string_literal: true

module KozenetUi
  class HeaderComponent < BaseComponent
    # ActionButton section for the HeaderComponent
    # Renders an action button (icon or text) in the header
    #
    # @example
    #   <%= render KozenetUi::HeaderComponent::ActionButtonComponent.new(href: "/cart", icon: :shopping_cart, label: "Cart") %>
    class ActionButtonComponent < BaseComponent
      PLACEMENTS = %i[start end].freeze
      PLACEMENT_ALIASES = {
        before: :start,
        left: :start,
        right: :end,
        after: :end
      }.freeze
      VISIBILITIES = %i[always desktop mobile].freeze
      VISIBILITY_ALIASES = {
        all: :always,
        both: :always
      }.freeze

      attr_reader :placement
      attr_reader :visible_on

      def initialize(
        href: "#",
        icon: nil,
        text: nil,
        label: nil,
        placement: :end,
        position: nil,
        visible_on: :desktop,
        **html_options
      )
        super(**html_options)
        @href = href
        @icon = icon
        @text = text
        @label = label
        @placement = normalize_placement(position || placement)
        @visible_on = normalize_visibility(visible_on)
      end

      private

      def action_button_attrs
        attrs = html_options.merge(
          href: @href,
          class: action_button_classes
        )
        attrs[:aria] = action_button_aria if action_button_aria.any?
        attrs
      end

      def action_button_classes
        classes = ["kz-action-btn"]
        classes << "kz-action-btn-with-text" if visible_text?
        classes << "kz-action-btn-placement-#{placement}"
        classes << "kz-action-visible-#{visible_on}"
        classes << @custom_class if defined?(@custom_class) && @custom_class
        classes.join(" ")
      end

      def action_button_aria
        aria = html_options.fetch(:aria, {}).dup
        aria[:label] = @label if @label.present?
        aria
      end

      def visible_text
        @text.presence || (content if content.present?)
      end

      def visible_text?
        visible_text.present?
      end

      def render_icon(icon)
        return unless icon

        helpers.kozenet_ui_icon(icon, class: "kz-action-btn-svg", size: 20)
      end

      def normalize_placement(value)
        normalized_value = value.to_s.tr("-", "_").to_sym
        normalized_value = PLACEMENT_ALIASES.fetch(normalized_value, normalized_value)
        return normalized_value if PLACEMENTS.include?(normalized_value)

        raise ArgumentError, "Unknown header action placement `#{value}`. Use :start or :end."
      end

      def normalize_visibility(value)
        normalized_value = value.to_s.tr("-", "_").to_sym
        normalized_value = VISIBILITY_ALIASES.fetch(normalized_value, normalized_value)
        return normalized_value if VISIBILITIES.include?(normalized_value)

        raise ArgumentError, "Unknown header action visibility `#{value}`. Use :always, :desktop, or :mobile."
      end
    end
  end
end
