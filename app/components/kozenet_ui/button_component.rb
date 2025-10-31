module KozenetUi
  # Apple-inspired button component with smooth interactions
  # Supports multiple variants, sizes, and states
  #
  # @example Basic usage
  #   <%= render KozenetUi::ButtonComponent.new(variant: :primary) do %>
  #     Click me
  #   <% end %>
  #
  # @example With helper
  #   <%= kz_button(variant: :primary, size: :lg) { "Sign up" } %>
  #
  # @example With icon slot
  #   <%= kz_button(variant: :secondary) do |button| %>
  #     <% button.with_icon do %>
  #       <svg>...</svg>
  #     <% end %>
  #     Save changes
  #   <% end %>
  #
  # @example As link
  #   <%= kz_button(variant: :ghost, href: "/path") { "Learn more" } %>
  #
  # @example Loading state
  #   <%= kz_button(variant: :primary, loading: true) { "Processing..." } %>
  class ButtonComponent < BaseComponent
    renders_one :icon

    def initialize(
      variant: :primary,
      size: :md,
      type: :button,
      href: nil,
      disabled: false,
      loading: false,
      full_width: false,
      **html_options
    )
      super(variant: variant, size: size, **html_options)
      @type = type
      @href = href
      @disabled = disabled
      @loading = loading
      @full_width = full_width
    end

    def call
      if link?
        link_tag
      else
        button_tag
      end
    end

    private

    def base_classes
      classes = [
        "kz-btn",
        "inline-flex items-center justify-center gap-2",
        "font-medium transition-all duration-200",
        "focus:outline-none focus-visible:ring-2 focus-visible:ring-offset-2",
        "disabled:opacity-50 disabled:cursor-not-allowed disabled:transform-none"
      ]
      
      classes << "w-full" if @full_width
      classes.join(" ")
    end

    def link?
      @href.present?
    end

    def button_tag
      tag.button(**button_attrs) do
        button_content
      end
    end

    def link_tag
      tag.a(**link_attrs) do
        button_content
      end
    end

    def button_content
      safe_join([
        icon_or_spinner,
        content_wrapper
      ].compact)
    end

    def icon_or_spinner
      if loading?
        spinner_icon
      elsif icon?
        tag.span(class: "kz-btn-icon") { icon }
      end
    end

    def spinner_icon
      tag.svg(
        class: "kz-btn-spinner animate-spin",
        width: "16",
        height: "16",
        viewBox: "0 0 24 24",
        fill: "none",
        stroke: "currentColor",
        stroke_width: "3",
        stroke_linecap: "round",
        stroke_linejoin: "round"
      ) do
        tag.path(d: "M21 12a9 9 0 1 1-6.219-8.56")
      end
    end

    def content_wrapper
      tag.span(class: "kz-btn-content") { content }
    end

    def button_attrs
      attrs = html_attrs
      attrs[:type] = @type.to_s
      attrs[:disabled] = true if disabled?
      attrs[:"aria-busy"] = "true" if loading?
      attrs[:"aria-disabled"] = "true" if disabled?
      attrs
    end

    def link_attrs
      attrs = html_attrs
      attrs[:href] = @href
      attrs[:role] = "button"
      attrs[:"aria-busy"] = "true" if loading?
      attrs[:"aria-disabled"] = "true" if disabled?
      attrs[:class] = [attrs[:class], "pointer-events-none"].join(" ") if disabled?
      attrs
    end

    def disabled?
      @disabled || @loading
    end

    def loading?
      @loading
    end
  end
end