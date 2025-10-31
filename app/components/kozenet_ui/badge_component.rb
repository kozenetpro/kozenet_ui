# frozen_string_literal: true

module KozenetUi
  # Badge component for labels, statuses, and counts
  # Supports multiple variants and sizes
  #
  # @example Status badge
  #   <%= kz_badge(variant: :success) { "Active" } %>
  #
  # @example Count badge
  #   <%= kz_badge(variant: :primary, size: :sm) { "99+" } %>
  #
  # @example With icon
  #   <%= kz_badge(variant: :warning) do |badge| %>
  #     <% badge.with_icon do %>
  #       <svg>...</svg>
  #     <% end %>
  #     Pending
  #   <% end %>
  class BadgeComponent < BaseComponent
    renders_one :icon

    def initialize(
      variant: :primary,
      size: :md,
      pill: true,
      **html_options
    )
      super(variant: variant, size: size, **html_options)
      @pill = pill
    end

    def call
      tag.span(**html_attrs) do
        badge_content
      end
    end

    private

    def base_classes
      classes = [
        "kz-badge",
        "inline-flex items-center gap-1",
        "font-semibold uppercase tracking-wider"
      ]
      classes << "rounded-full" if @pill
      classes.join(" ")
    end

    def badge_content
      if icon?
        safe_join([
          tag.span(class: "kz-badge-icon") { icon },
          tag.span { content }
        ])
      else
        content
      end
    end
  end
end