# frozen_string_literal: true

module KozenetUi
  # Avatar component for user profiles and images
  # Supports images, initials, and icons with multiple sizes
  #
  # @example With image
  #   <%= kz_avatar(src: user.avatar_url, alt: user.name) %>
  #
  # @example With initials
  #   <%= kz_avatar(initials: "JD", variant: :primary) %>
  #
  # @example With custom size
  #   <%= kz_avatar(src: url, size: :lg) %>
  class AvatarComponent < BaseComponent
    # rubocop:disable Metrics/ParameterLists
    def initialize(
      src: nil,
      alt: "Avatar",
      initials: nil,
      variant: :primary,
      size: :md,
      html_options: {}
    )
      super(variant: variant, size: size, **html_options)
      @src = src
      @alt = alt
      @initials = initials
    end
    # rubocop:enable Metrics/ParameterLists

    def call
      tag.div(**html_attrs) do
        avatar_content
      end
    end

    private

    def base_classes
      "kz-avatar inline-flex items-center justify-center overflow-hidden"
    end

    def avatar_content
      if @src.present?
        tag.img(src: @src, alt: @alt, class: "w-full h-full object-cover")
      elsif @initials.present?
        tag.span(class: "kz-avatar-initials") { @initials }
      else
        default_icon
      end
    end

    # rubocop:disable Metrics/MethodLength
    def default_icon
      tag.svg(
        width: "20",
        height: "20",
        viewBox: "0 0 24 24",
        fill: "none",
        stroke: "currentColor",
        stroke_width: "2"
      ) do
        safe_join([
                    tag.circle(cx: "12", cy: "8", r: "5"),
                    tag.path(d: "M20 21a8 8 0 1 0-16 0")
                  ])
      end
    end
    # rubocop:enable Metrics/MethodLength
  end
end
