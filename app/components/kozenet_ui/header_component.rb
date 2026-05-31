# frozen_string_literal: true

module KozenetUi
  # Header component for navigation and branding
  # Supports sticky and blur options, and slots for brand, nav, actions, etc.
  #
  # @example Basic usage
  #   <%= kz_header(sticky: true, blur: true) do |header| %>
  #     <% header.brand { ... } %>
  #     <% header.nav_items { ... } %>
  #   <% end %>
  class HeaderComponent < BaseComponent
    renders_one :brand, "KozenetUi::HeaderComponent::BrandComponent"
    renders_one :search, "KozenetUi::HeaderComponent::SearchComponent"
    renders_many :nav_items, "KozenetUi::HeaderComponent::NavItemComponent"
    renders_many :action_buttons, "KozenetUi::HeaderComponent::ActionButtonComponent"
    renders_one :cta, "KozenetUi::HeaderComponent::CtaComponent"
    renders_one :user_menu, "KozenetUi::HeaderComponent::UserMenuComponent"
    renders_one :mobile_menu

    def initialize(
      sticky: BaseComponent::UNSET,
      blur: BaseComponent::UNSET,
      **html_options
    )
      super(**html_options)
      @sticky = component_option(:header, :sticky, sticky, fallback: true)
      @blur = component_option(:header, :blur, blur, fallback: true)
    end

    private

    def base_classes
      classes = ["kz-header"]
      classes << "kz-header-sticky" if @sticky
      classes << "kz-header-blur" if @blur
      classes.join(" ")
    end

    def start_action_buttons
      action_buttons_for(:start)
    end

    def start_action_buttons?
      start_action_buttons.any?
    end

    def end_action_buttons
      action_buttons_for(:end)
    end

    def end_action_buttons?
      end_action_buttons.any?
    end

    def action_buttons_for(placement)
      return [] unless action_buttons?

      action_buttons.select { |button| button.placement == placement }
    end
  end
end
